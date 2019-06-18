if test -x "/usr/local/bin/brew"
  set -x HOMEBREW_PREFIX "/usr/local"
else if test -x "/home/linuxbrew/.linuxbrew/bin/brew"
  set -x HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
else if test -x "$HOME/.linuxbrew/bin/brew"
  set -x HOMEBREW_PREFIX "$HOME/.linuxbrew"
end

if set -q HOMEBREW_PREFIX
  set -x HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
  set -x HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
  set -x PATH "$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
  if set -q MANPATH
    set -x MANPATH "$HOMEBREW_PREFIX/share/man:$MANPATH"
  else
    set -x MANPATH "$HOMEBREW_PREFIX/share/man"
  end
  if set -q INFOPATH
    set -x INFOPATH "$HOMEBREW_PREFIX/share/info:$INFOPATH"
  else
    set -x INFOPATH "$HOMEBREW_PREFIX/share/info"
  end
end
