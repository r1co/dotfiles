

# nvm 
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# global yarn 
export PATH="$PATH:`yarn global bin`"

# platformio
export PATH="$PATH:/home/r1co/.platformio/penv/bin"

# pip 
export PATH="$PATH:/home/r1co/.local/bin"

# go 
export PATH="$PATH:/home/r1co/go/bin"


# linux
alias open="flatpak run re.sonny.Junction"