
if [ -z ${DOT_PREFIX+x} ];
then
    DOT_PREFIX="dot"
fi

echo "DOT_PREFIX: $DOT_PREFIX"


source $(dirname $0)/utils/colors.zsh
source $(dirname $0)/utils/utils.zsh
source $(dirname $0)/utils/log.zsh
source $(dirname $0)/config.zsh
source $(dirname $0)/module.zsh
source $(dirname $0)/repo.zsh
