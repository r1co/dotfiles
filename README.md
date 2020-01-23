# README _WIP_ #

Configuration for zsh and tmux.

## Install
```
bash <(curl -s https://raw.githubusercontent.com/r1co/dotfiles/master/install.sh) 
```

## File Structure 
```
.
+-- aliases.zsh 	# zsh aliases 
+-- colors.zsh  	# colors and color switch aliases 
+-- tmux.conf   	# tmux config
+-- vars.zsh    	# other variables
+-- functions.zsh   # helper functions 
+-- themes 			
|   +-- default.zsh # default theme 
+-- flags # enable / disable functionality by adding files 

```

## Hostname themes 
You can define custom themes for specific hostnames. 

### Add custom theme
```bash
`touch /.dotfiles`/themes/$(hostname).zsh
```

You can now override variables defined in `themes/default.zsh`

## Workspaces 

- `w` switches to workspace (`cd $WORKSPACE`).
- `ws.set` set the current location as workspace.
- `ws.setpath <path>` set path as workspace 
- `ws.print` print the current workspace path  

## Autostart tmux 

Touch `~/.dotfiles/flags/tmux_autostart.flag` to enable tmux autostart 

## Env Flags 
$DOTFILES_DISABLE_TMUX=1
