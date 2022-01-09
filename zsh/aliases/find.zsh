
# find
defineCommonAlias find.file 'findFile'
defineCommonAlias find.inFile 'findInFile'
defineCommonAlias find.bigFiles 'findBigFiles'
defineCommonAlias find.dir 'findDir'

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
