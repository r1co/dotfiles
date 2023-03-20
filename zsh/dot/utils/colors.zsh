
# parse color string (123,123,123) to array
function parse_color(){
    local color=("$(echo $1 | sed -E 's/,/ /'g)")
    echo "${color[@]}"
}

function find_text_color(){
    rgb=($(parse_color "$1"))
    r=${rgb[1]}
    g=${rgb[2]}
    b=${rgb[3]}
    color=$(($r * 0.299 + $g * 0.587 + $b * 0.114))
    color=$(printf "%.0f\n" "$color")
    if [ "$color" -gt 186 ]; then
        echo $COLOR_TEXT_BLACK
    else
        echo $COLOR_TEXT_WHITE
    fi
    # return (r * 0.299 + g * 0.587 + b * 0.114) > 186
    # ? $COLOR_TEXT_BLACK
    # : $COLOR_TEXT_WHITE
}

function set_fg_color(){
    rgb=($(parse_color "$1"))
    r=${rgb[1]}
    g=${rgb[2]}
    b=${rgb[3]}
    printf '\e[38;2;%s;%s;%sm' "$r" "$g" "$b"
    # printf '\e[K'
}

function set_bg_color(){
    rgb=($(parse_color "$1"))
    r=${rgb[1]}
    g=${rgb[2]}
    b=${rgb[3]}
    printf '\e[48;2;%s;%s;%sm' "$r" "$g" "$b"
    # printf '\e[K'
}

function reset_colors(){
    printf '\e[m\x1B[K'
}

function print_color(){
    local fe_color=$1
    set_fg_color $fe_color
    local message=""
    
    if [ "$#" -eq 2 ]; then
        message=$2
        
        elif [ "$#" -eq 3 ]; then
        local be_color=("$2")
        set_bg_color $be_color
        message=$3
    else
        echo "Error parsing parameters"
        return
    fi
    echo $message
    reset_colors
}


function printRed(){
    print_color $COLOR_ERROR "$@"
}

function printBlue(){
    print_color $COLOR_INFO "$@"
}

function printYellow(){
    print_color $COLOR_WARN "$@"
    
}

