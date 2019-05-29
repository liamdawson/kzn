#shellcheck shell=sh

if [ -d "${HOME}/.local/bin" ]
then
  export PATH="${PATH}:${HOME}/.local/bin"
fi

if [ -d "${HOME}/.cargo/bin" ]
then
  export PATH="${PATH}:${HOME}/.cargo/bin"
fi
