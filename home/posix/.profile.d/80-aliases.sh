#shellcheck shell=sh

command -v 'pbcopy' >/dev/null || alias pbcopy='xclip -sel clip'
alias tm='tmux new'
alias dx='direnv exec .'
alias bx='bundle exec'
