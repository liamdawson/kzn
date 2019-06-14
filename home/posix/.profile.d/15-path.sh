#shellcheck shell=sh

if [ -d "${HOME}/.local/bin" ]
then
  export PATH="${HOME}/.local/bin:${PATH}"
fi

if [ -d "${HOME}/.cargo/bin" ]
then
  export PATH="${PATH}:${HOME}/.cargo/bin"
fi
