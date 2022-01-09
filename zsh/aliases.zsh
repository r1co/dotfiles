
for file in $(find $ZSH_ALIASES_CONFIG_ROOT -name "*.zsh" -type f); do 
  DEBUG "Parse aliases in $file"
  source $file
done
