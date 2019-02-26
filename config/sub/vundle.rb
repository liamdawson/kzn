require 'English'

VUNDLE_SRC='https://github.com/VundleVim/Vundle.vim.git'
VUNDLE_DEST=File.join(ENV['HOME'], '.vim', 'bundle', 'Vundle.vim')

def vim_installed?
  `command -v vim`
  $CHILD_STATUS.success?
end

if vim_installed? && !Dir.exist?(VUNDLE_DEST) 
  unless system("git clone #{VUNDLE_SRC} #{VUNDLE_DEST}")
    abort('failed to install vundle')
  end
end
