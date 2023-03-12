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
