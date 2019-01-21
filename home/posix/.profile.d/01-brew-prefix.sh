#shellcheck shell=sh

if test -x "/usr/local/bin/brew"; then
  export HOMEBREW_PREFIX="/usr/local"
elif test -x "/home/linuxbrew/.linuxbrew/bin/brew"; then
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
elif test -x "${HOME}/.linuxbrew/bin/brew"; then
  export HOMEBREW_PREFIX="${HOME}/.linuxbrew"
fi
