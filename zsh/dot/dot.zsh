
if [ -z ${DOT_PREFIX+x} ];
then
    DOT_PREFIX=".dot"
fi

# set completion
fpath=($(dirname $0)/completions $fpath)

source $(dirname $0)/utils/colors.zsh
source $(dirname $0)/utils/utils.zsh
source $(dirname $0)/utils/log.zsh
source $(dirname $0)/config.zsh

# setup mods
${DOT_PREFIX}.config.setup

source $(dirname $0)/module.zsh
source $(dirname $0)/repo.zsh
source $(dirname $0)/debug.zsh
source $(dirname $0)/theme.zsh
