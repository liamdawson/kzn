source ~/.config/zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "themes/frisk", from:oh-my-zsh, as:theme

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(
#   colored-man-pages
#   cp
#   web-search
#   gas
#   gitignore
# )

zplug load

source "${HOME}/.zshrc.local"
