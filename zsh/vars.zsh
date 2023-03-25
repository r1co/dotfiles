DOTFILES_ROOT="$HOME/.dotfiles"

ZSH_ROOT="$DOTFILES_ROOT/zsh"
ZSH_STORAGE_ROOT="$ZSH_ROOT/.storage"
OPTIONS_ROOT="$ZSH_STORAGE_ROOT/options"

ZSH_ALIASES_CONFIG_ROOT="$ZSH_ROOT/aliases"
ZSH_PLUGIN_ROOT="$ZSH_ROOT/plugins"

THEME_ROOT="$ZSH_ROOT/themes"


source "$ZSH_ROOT/colors.zsh"
# COLORS_INFOBAR=( (255 0 0) (0 255 0) (0 0 255) )


## COLORS
# YELLOW='11'
# BLUE='25'
# CYAN='14'
# RED='\033[00;31m'
# GREEN='\033[00;32m'
# PURPLE='\033[00;35m'
# LIGHTGRAY='\033[00;37m'
# WHITE='\033[00;37m'

# # input: r, g, b
# to_hex_color(){
#     for var in "$@"
#     do
#         printf '%02x' "$var";
#     done
#     printf '\n'
# }

# # # input: r, g, b
# to_shell_color(){
#     r=$1
#     g=$2
#     b=3
#     printf '%03d' "$(( (r<75?0:(r-35)/40)*6*6 +
#                        (g<75?0:(g-35)/40)*6   +
#     (b<75?0:(b-35)/40)     + 16 ))"
# }


# mode2header(){
#     #### For 16 Million colors use \e[0;38;2;R;G;Bm each RGB is {0..255}
#     printf '\e[mR\n' # reset the colors.
#     printf '\n\e[m%59s\n' "Some samples of colors for r;g;b. Each one may be 000..255"
#     printf '\e[m%59s\n'   "for the ansi option: \e[0;38;2;r;g;bm or \e[0;48;2;r;g;bm :"
# }
mode2colors(){
    # foreground or background (only 3 or 4 are accepted)
    local fb="$1"
    [[ $fb != 3 ]] && fb=4
    local samples=(0  63 127 191 255)
    # local samples=(0 63 127 191 255)
    for         r in {0..255}; do
        for     g in {0..255}; do
            for b in {0..255}; do
                # echo  "$r" "$g" "$b"
                # echo $r $g $b
                # hex_color=$(to_hex_color $r $g $b)
                # shell_color=$(to_shell_color $r $g $b)
                # echo $hex_color
                # echo $shell_color
                # printf '\e[0;%s8;2;%s;%s;%sm ' "$fb" "$r" "$g" "$b" # "$r" "$g" "$b" "$(to_shell_color $r $g $b))"
                # printf '\e[0;%s8;2;%s;%s;%sm%03d;%03d;%03d(%s) ' "$fb" "$r" "$g" "$b" "$r" "$g" "$b" "$(to_shell_color $r $g $b))"
            done;
        done; printf '\e[m'
    done; printf '\e[mReset\n'
}
# # mode2hea s 3
# mode2colors 4