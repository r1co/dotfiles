VERBOSE "Fix ctrl -> / ctrl <- using bindkeys"

# fix ctrl + -> <-
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word