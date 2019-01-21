#shellcheck shell=sh

test ! -f "/etc/profile" || . /etc/profile

if test -d "${HOME}/.profile.d"
then
  for i in "${HOME}"/.profile.d/*.sh
  do
    if test -r "$i"
    then
        . "$i"
    fi
  done
fi
