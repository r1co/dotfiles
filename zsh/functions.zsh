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

function noop() {

}


function defineFlag () {
  FLAG_EXT=$3
  FLAG_ALIAS_PREFIX=$4

  ALL_FLAGS+=($1)

  # define flag enable/disable aliases
  alias $FLAG_ALIAS_PREFIX.enable.$1="touch $FLAG_ROOT/$1$FLAG_EXT && echo '$1 enabled'"
  alias $FLAG_ALIAS_PREFIX.disable.$1="rm -f $FLAG_ROOT/$1$FLAG_EXT && echo '$1 disabled'"

  DEBUG "alias $FLAG_ALIAS_PREFIX.enable.$1 created"
  DEBUG "alias $FLAG_ALIAS_PREFIX.disable.$1 created"

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




# get pid and command for given name
getPidAndCommand() {
	if [ -z "$1" ]
  	then
  		echo "Usage sys.pid <command>"
  		exit 1
  	fi
	ps aux | grep $1 | xargs -L1 | cut -d' ' -f 2,11
}

findFile() {
	FILENAME=$1
	SEARCH_PATH=$2

	if [ -z "$FILENAME" ]
  	then
        echo "usage find.file <filename> (<searchpath>)"
        exit 1
    fi

    if [ -z "$SEARCH_PATH" ]
  	then
        SEARCH_PATH=$(pwd)
    fi

	echo "search for ${FILENAME} in $SEARCH_PATH"
	find $SEARCH_PATH -iname $FILENAME -type f -print

}

findInFile() {
	SEARCHTEXT=$1
	SEARCH_PATH=$2

	if [ -z "$SEARCHTEXT" ]
  	then
        echo "usage find.inFile <SEARCHTEXT> (<searchpath>)"
        exit 1
    fi

    if [ -z "$SEARCH_PATH" ]
  	then
        SEARCH_PATH=$(pwd)
    fi

	echo "search for text ${FILENAME} in $SEARCH_PATH"
	find $SEARCH_PATH -type f -exec grep -il $SEARCHTEXT {} \;

}

findBigFiles() {
	SIZE=$1
	SEARCH_PATH=$2

	if [ -z "$SIZE" ]
  	then
        echo "usage find.inFile <SIZE> (<searchpath>)"
        exit 1
    fi

    if [ -z "$SEARCH_PATH" ]
  	then
        SEARCH_PATH=$(pwd)
    fi

	echo "search for filesize $SIZE in $SEARCH_PATH"
	find $SEARCH_PATH -type f -size $SIZE -exec ls -lh {} \; | xargs -L1 | cut -d " " -f5,9-

}

findDir () {
	FILENAME=$1
	SEARCH_PATH=$2

	if [ -z "$FILENAME" ]
  	then
        echo "usage find.dir <name> (<searchpath>)"
        exit 1
    fi

    if [ -z "$SEARCH_PATH" ]
  	then
        SEARCH_PATH=$(pwd)
    fi

	echo "search for ${FILENAME} in $SEARCH_PATH"
	find $SEARCH_PATH -iname $FILENAME -type d -print

}
