if [ -d "$HOME/.local/bin" ]
  set -x PATH "$HOME/.local/bin:$PATH"
end

if [ -d "$HOME/.cargo/bin" ]
  set -x PATH "$PATH:$HOME/.cargo/bin"
end
