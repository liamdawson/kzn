#shellcheck shell=bash

if [ -n "$ZSH_VERSION" ]
then
  function pet-select() {
    BUFFER=$(pet search --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
  }
  zle -N pet-select
  stty -ixon
  bindkey '^s' pet-select
elif [ -n "$BASH_VERSION" ]
then
  function pet-select() {
    BUFFER=$(pet search --query "$READLINE_LINE")
    READLINE_LINE=$BUFFER
    READLINE_POINT=${#BUFFER}
  }
  bind -x '"\C-x\C-r": pet-select'
fi
