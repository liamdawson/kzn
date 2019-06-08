#shellcheck shell=zsh

test ! -f "/etc/zprofile" || . /etc/zprofile
[[ -r "${HOME}/.profile" ]] && source "${HOME}/.profile"
