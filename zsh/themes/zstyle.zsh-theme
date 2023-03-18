
autoload -Uz compinit; compinit
autoload -Uz vcs_info

CURRENT_BG='NONE'


case ${SOLARIZED_THEME:-dark} in
    light) CURRENT_FG='white';;
    *)     CURRENT_FG='black';;
esac

() {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    # NOTE: This segment separator character is correct.  In 2012, Powerline changed
    # the code points they use for their special characters. This is the new code point.
    # If this is not working for you, you probably have an old version of the
    # Powerline-patched fonts installed. Download and install the new version.
    # Do not submit PRs to change this unless you have reviewed the Powerline code point
    # history and have new information.
    # This is defined using a Unicode escape sequence so it is unambiguously readable, regardless of
    # what font the user is viewing this source code in. Do not replace the
    # escape sequence with a single literal character.
    # Do not change this! Do not make it '\u2b80'; that is the old, wrong code point.
    SEGMENT_SEPARATOR=$'\ue0b0'
}

# SEGMENT/VCS_STATUS_LINE ======================================================
export VCS="git"

local current_vcs="\":vcs_info:*\" enable $VCS"
local char_badge="%F{238} 𝗈𝗇 %f%F{236}${char_arrow}%f"
local vc_branch_name="%F{232}%b%f"

local vc_action="%F{238}%a %f%F{236}${char_arrow}%f"
local vc_unstaged_status="%F{232} M ${char_arrow}%f"

local vc_git_staged_status="%F{115} A ${char_arrow}%f"
local vc_git_hash="%F{151}%6.6i%f %F{236}${char_arrow}%f"
local vc_git_untracked_status="%F{74} U ${char_arrow}%f"


eval zstyle $current_vcs
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true

# git sepecific
zstyle ':vcs_info:git*+set-message:*' hooks use_git_untracked
zstyle ':vcs_info:git:*' stagedstr $vc_git_staged_status
zstyle ':vcs_info:git:*' unstagedstr $vc_unstaged_status
zstyle ':vcs_info:git:*' actionformats "  ${vc_action} ${vc_git_hash}%m%u%c${char_badge} ${vc_branch_name}"
zstyle ':vcs_info:git:*' formats " %c%u%m${char_badge} ${vc_branch_name}"

# Show untracked file status char on git status line
+vi-use_git_untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == "true" ]] &&
    git status --porcelain | grep -m 1 "^??" &>/dev/null; then
        hook_com[misc]=$vc_git_untracked_status
    else
        hook_com[misc]=""
    fi
}

# Prepare git status line
prepareGitStatusLine() {
    echo '${vcs_info_msg_0_}'
}

# PROMPT ===============================================================


# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
    local bg fg
    [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
    [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
    if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
        echo -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
    else
        echo -n "%{$bg%}%{$fg%} "
    fi
    CURRENT_BG=$1
    [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    else
        echo -n "%{%k%}"
    fi
    echo -n "%{%f%}"
    CURRENT_BG=''
}


prompt_context() {
    if [[ -n "$SSH_CLIENT" ]]; then
        prompt_segment 214 black "%(!.%{%F{yellow}%}.)%n@%m "
    else
        prompt_segment black default "%(!.%{%F{yellow}%}.)%n@%m "
    fi
}

# Git: branch/detached head, dirty status
prompt_git() {
    prompt_segment yellow black "$(prepareGitStatusLine)"
}

prompt_dir(){
    prompt_segment 25 white ' %~ '
}

prompt_cursor(){
    if [[ -n "$SSH_CLIENT" ]]; then
        prompt_segment 214 black ''
        prompt_end
    else
        prompt_segment black default ''
        prompt_end
    fi
}

precmd() {
    vcs_info
}

setopt PROMPT_SUBST

build_prompt() {
    RETVAL=$?
    prompt_context
    prompt_dir
    prompt_git
    prompt_end
}

PROMPT="%{%f%b%k%}$(build_prompt)
$(prompt_cursor) "

