source $HOME/.dotfiles/zsh/zshrc.zsh



# global yarn
export PATH="$PATH:`yarn global bin`"

# platformio
export PATH="$PATH:/home/r1co/.platformio/penv/bin"

# pip
export PATH="$PATH:/home/r1co/.local/bin"

# go
export PATH="$PATH:/home/r1co/go/bin"
export GO111MODULE=on

# android
export PATH="$PATH:/home/r1co/Projects/Android/SDK/cmdline-tools/bin"
export PATH="$PATH:/home/r1co/Projects/Android/SDK/sdk/tools"
export PATH="$PATH:/home/r1co/Projects/Android/SDK/sdk/platform-tools"

export ANDROID_SDK_ROOT="/home/r1co/Projects/Android/SDK/sdk"

# linux
alias gitkraken="flatpak run com.axosoft.GitKraken"
alias open="flatpak run re.sonny.Junction"
alias wezterm='flatpak run org.wezfurlong.wezterm'

# nvm compinit
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# jenv
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"


# # Load Angular CLI autocompletion.
# source <(ng completion script)


