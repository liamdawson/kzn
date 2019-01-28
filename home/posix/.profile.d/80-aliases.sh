#shellcheck shell=sh

command -v 'pbcopy' >/dev/null || alias pbcopy='xclip -sel clip'