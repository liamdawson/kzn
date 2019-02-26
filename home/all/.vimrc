set nocompatible
set number
set ruler

filetype off

syntax on
colorscheme noctu

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'jamessan/vim-gnupg'

call vundle#end()            " required
filetype plugin indent on    " required
