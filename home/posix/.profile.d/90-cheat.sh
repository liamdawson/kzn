#shellcheck shell=zsh

if [[ ! -z "${ZSH_VERSION:-}" ]]
then
  function cheat() {
    mdless "${HOME}/cheat/$1"
  }

  compctl -W "${HOME}"/cheat/ -f cheat
fi
