# Define a flag.
# defineFlag "<flag-name>" <handlerfn>
declare -a ALL_FLAGS=()

# print only if debug flag is set
function DEBUG () {
  # do not use checkFlag here!!!
  FLAG="$FLAG_ROOT/debug$ZSH_FLAG_EXT"
  if test -f "$FLAG"; then
    echo "DEBUG: $1"
  fi
}
function DEBUG_ALIASES () {
  # do not use checkFlag here!!!
  FLAG="$FLAG_ROOT/debug-aliases$ZSH_FLAG_EXT"
  if test -f "$FLAG"; then
    echo "DEBUG: $1"
  fi
}

function noop() {

}


function defineFlag () {
  FLAG_EXT=$3
  FLAG_ALIAS_PREFIX=$4

  ALL_FLAGS+=($1)

  # define flag enable/disable aliases
  alias $FLAG_ALIAS_PREFIX.enable.$1="touch $FLAG_ROOT/$1$FLAG_EXT && echo '$1 enabled'"
  alias $FLAG_ALIAS_PREFIX.disable.$1="rm -f $FLAG_ROOT/$1$FLAG_EXT && echo '$1 disabled'"

  # DEBUG "alias $FLAG_ALIAS_PREFIX.enable.$1 created"
  # DEBUG "alias $FLAG_ALIAS_PREFIX.disable.$1 created"

  if checkFlag $1 $FLAG_EXT; then
    $2
  fi
}

# Check if flag is set
function checkFlag () {
  local FLAG_EXT=$2
  FLAG="$FLAG_ROOT/$1$FLAG_EXT"
  if test -f "$FLAG"; then
    DEBUG "flag: $1 enabled"
    return 0;
  fi
  DEBUG "flag: $1 disabled"
  return 1;
}

function defineZshFlag () {
  defineFlag $1 $2 $ZSH_FLAG_EXT $ZSH_FLAG_ALIAS_PREFIX
}

function defineTmuxFlag () {
  defineFlag $1 noop $TMUX_FLAG_EXT $TMUX_FLAG_ALIAS_PREFIX
}

function getPlatform() {
  if [[ "$(uname)" == "Darwin" ]]; then
      echo "Darwin"
      return "Darwin"
  elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
      echo "Linux"
      return "Linux"
  fi
  echo "Unkown" 
  return "Unkown" 
}

function isDarwin() {
  platform=$(getPlatform)
  if [[ "$platform" == "Darwin" ]]; then
    echo true
    return true
  fi
  echo false 
  return false
}

function isLinux() {
  platform=$(getPlatform)
  if [[ "$platform" == "Linux" ]]; then
    echo true
    return true
  fi
  echo false 
  return false
}

function defineCommonAlias() {
  name=$1
  command=$2

  DEBUG_ALIASES "Add common alias $name"
  alias $name=$command
}

function defineLinuxAlias() {
  name=$1
  command=$2

  if [[ "$(isLinux)" == true ]]; then
    DEBUG_ALIASES "Add linux alias $name"
    alias $name=$command
  else
    DEBUG_ALIASES "Ignore alias $name for platform $(getPlatform)"
  fi
}

function defineOSXAlias() {
  name=$1
  command=$2

  if [[ "$(isDarwin)" == true ]]; then
    DEBUG_ALIASES "Add osx alias $name"
    alias $name=$command
  else
    DEBUG_ALIASES "Ignore alias $name for platform $(getPlatform)"
  fi
}

function printRed(){
  COLOR='\033[0;31m'
	NC='\033[0m' # No Color
	echo "${COLOR}$@${NC}"
}
function printBlue(){
  COLOR='\033[0;34m'
	NC='\033[0m' # No Color
	echo "${COLOR}$@${NC}"
}
function printYellow(){
  COLOR='\033[0;33m'
	NC='\033[0m' # No Color
	echo "${COLOR}$@${NC}"
}



# get pid and command for given name
getPidAndCommand() {
	if [ -z "$1" ]
  	then
  		echo "Usage sys.pid <command>"
  		exit 1
  	fi
	ps aux | grep $1 | xargs -L1 | cut -d' ' -f 2,11
}


