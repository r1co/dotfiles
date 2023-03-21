
autoload -Uz compinit; compinit
autoload -Uz vcs_info

CURRENT_BG='NONE'
char_arrow=">"

# zstyle ':vcs_info:*+*:*' debug true

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

# ENV/VARIABLES/LS_COLORS ======================================================

LSCOLORS=gxafexDxfxegedabagacad
export LSCOLORS

LS_COLORS=$LS_COLORS:"di=36":"ln=30;45":"so=34:pi=1;33":"ex=35":"bd=34;46":"cd=34;43":"su=30;41":"sg=30;46":"ow=30;43":"tw=30;42":"*.js=01;33":"*.json=33":"*.jsx=38;5;117":"*.ts=38;5;75":"*.css=38;5;27":"*.scss=38;5;169"
export LS_COLORS



# PROMPT ===============================================================


# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
    local bg fg
    [[ -n $1 ]] && bg="$1" || bg="$MOCHA_COLOR_SUBTEXT1"
    [[ -n $2 ]] && fg="$2" || fg="$MOCHA_COLOR_MAROON"
    if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
        # echo -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
        echo -n "$(set_fg_color $CURRENT_BG)"
        echo -n "$(set_bg_color $bg)"
        echo -n "$SEGMENT_SEPARATOR"
        echo -n "$(set_fg_color $fg)"
    else
        echo -n "$(set_fg_color $fg)"
        echo -n "$(set_bg_color $bg)"
    fi
    CURRENT_BG=$1
    [[ -n $3 ]] && echo -n " $3"
    
}

# begin a segement in the next color
segment_counter=0

increase_segment_counter(){
    local num_colors=${#SEGMENT_COLORS[@]}
    if [ "$segment_counter" -lt $num_colors ]; then
        let segment_counter+=1
    else
        let segment_counter=1
    fi
}

next_segment(){
    increase_segment_counter
    local num_colors=${#SEGMENT_COLORS[@]}
    local color=${SEGMENT_COLORS[$segment_counter]}
    local text_color=$(find_text_color $color)
    
    prompt_segment  $color $text_color $1
    
    
}

extend_segment(){
    local num_colors=${#SEGMENT_COLORS[@]}
    local color=${SEGMENT_COLORS[$segment_counter]}
    local text_color=$(find_text_color $color)
    
    prompt_segment  $color $text_color $1
}

colored_segment(){
    local num_colors=${#SEGMENT_COLORS[@]}
    local color=${SEGMENT_COLORS[$1]}
    local text_color=$(find_text_color $color)
    prompt_segment  $color $text_color $2
}

# End the prompt, closing any open segments
prompt_end() {
    reset_colors
    if [[ -n $CURRENT_BG ]]; then
        set_fg_color $CURRENT_BG
        echo -n "$SEGMENT_SEPARATOR"
        
    fi
    reset_colors
    CURRENT_BG=''
}


prompt_context() {
    if [[ -n "$SSH_CLIENT" ]]; then
        next_segment "%(!.%{%F{yellow}%}.)SSH %n@%m "
    else
        next_segment "@%m "
    fi
}

# Git: branch/detached head, dirty status
prompt_git() {
    [[ -n $vcs_info_msg_0_ ]] &&  next_segment "🌴 ${vcs_info_msg_0_}"
}

prompt_docker(){
    local docker_context="$(find-docker-context)"
    if [[ $docker_context != 'default' ]]; then
        prompt_segment $DOCKER_BG_COLOR "$DOCKER_FG_COLOR" "🐳 $(find-docker-context)"
    fi
}

prompt_dir(){
    next_segment '%50<...<%~%<< '
}

prompt_cursor(){
    ## escape colors
    echo -n '%F{\e[38;2;137;180;250m}'
    echo -n "$SEGMENT_SEPARATOR"
    echo -n '%F{\e[m\x1B[K}'
}

precmd() {
    vcs_info
    echo ""
}

setopt PROMPT_SUBST

build_prompt() {
    RETVAL=$?
    prompt_context
    prompt_dir
    prompt_git
    prompt_docker
    # next_segment "DOCKER"
    prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt)
$(prompt_cursor) %f'
RPROMPT=""

# SEGMENT/COMPLETION ===========================================================

setopt MENU_COMPLETE

local completion_descriptions="%B%F{85} ${char_arrow} %f%%F{green}%d%b%f"
local completion_warnings="%F{yellow} ${char_arrow} %fno matches for %F{green}%d%f"
local completion_error="%B%F{red} ${char_arrow} %f%e %d error"

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list "m:{a-z}={A-Z}"
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:*:*:descriptions' format $completion_descriptions
zstyle ':completion:*:*:*:*:corrections' format $completion_error
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS} "ma=38;5;253;48;5;23"
zstyle ':completion:*:*:*:*:warnings' format $completion_warnings
zstyle ':completion:*:*:*:*:messages' format "%d"

zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:approximate:*' max-errors "reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )"
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns "*?.o" "*?.c~" "*?.old" "*?.pro"
zstyle ':completion:*:functions' ignored-patterns "_*"

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# ==============================================================================



# SEGMENT/VCS_STATUS_LINE ======================================================
export VCS="git"

local current_vcs="\":vcs_info:*\" enable $VCS"
local char_badge=""
local vc_branch_name="%b"

local vc_action="%F{238}%a %f%F{236}${char_arrow}%f"
local vc_unstaged_status="\u270E"

local vc_git_staged_status="\u2a"
local vc_git_hash="%F{151}%6.6i%f %F{236}${char_arrow}%f"
vc_git_untracked_status="+"

eval zstyle $current_vcs
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true

# git sepecific
zstyle ':vcs_info:git*+set-message:*' hooks use_git_untracked
zstyle ':vcs_info:git:*' stagedstr $vc_git_staged_status
zstyle ':vcs_info:git:*' unstagedstr $vc_unstaged_status
zstyle ':vcs_info:git:*' actionformats "AF  ${vc_action} ${vc_git_hash}%m%u%c${char_badge} ${vc_branch_name}"
zstyle ':vcs_info:git:*' formats "${vc_branch_name} %u%c%m "

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
# prepareGitStatusLine() {
#     echo '${vcs_info_msg_0_}'
# }

# ==============================================================================