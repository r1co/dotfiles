# `.files`

My dotfiles. 

## Install
```
bash <(curl -s https://raw.githubusercontent.com/r1co/dotfiles/master/install.sh) 
```

### File Structure 
```
.
├─ install.sh       # install dotfiles 
├─ uninstall.sh     # uninstall dotfiles 
├─ git              # git config 
├─ scripts          # scripts that are added to $PATH 
├─ tmux             # tmux config 
├─ wezterm          # wezterm config 
├─ zsh              # zsh config 
│  ├─ vars.zsh      # global zsh variables 
│  └─ zshrc.zsh     # zsh main config file 

```

## ZSH
### **Flags** 

Flags can be used to apply zsh config or execute any kind of shell script on startup.

Flags are only executed if the corresponding flag enable file exists. 

To add a new flag put a file containing a `$HANDLER_NAME` function in `$ZSH_FLAG_CONFIG_ROOT`. 

This will create a new flag named like the file. 

Example flag:
```bash
function $HANDLER_NAME(){
    echo "This flag says hello if enabled"
}
```

### **Aliases**

All files in `$ZSH_ALIASES_CONFIG_ROOT` are automatically loaded on startup. 

Aliases can be defined in several ways: 

* zsh alias: 

  `alias my-program=ls -la`

* common alias (alias that will be created on all platforms)

  `defineCommonAlias date.week "date +%V"`
* linux alias

  `defineLinuxAlias date.week "date +%V"`
* osx alias

  `defineOSXAlias date.week "date +%V"`