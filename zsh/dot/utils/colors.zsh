COLOR_RESET='\033[0m'



function printRed(){
    COLOR=$RED
    echo "${COLOR}$@${COLOR_RESET}"
}

function printBlue(){
    COLOR=$BLUE
    echo "${COLOR}$@${COLOR_RESET}"
}

function printYellow(){
    COLOR=$YELLOW
    echo "${COLOR}$@${COLOR_RESET}"
}
