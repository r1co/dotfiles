source $HOME/.dotfiles/zsh/zshrc.zsh


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"


export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin:/Users/enrico.weigelt/JOBS/NPM/lzdev/bin"

# configure mmctl
source <(mmctl completion zsh)

# Load Angular CLI autocompletion.
source <(ng completion script)


export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

