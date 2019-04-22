installs = [
  -> { system('rbenv install -s 2.6.2') },
  -> { system('pyenv install -s 3.7.2') },
  -> { system('pyenv install -s 2.7.15') },
  -> { system('nodenv install -s 10.15.0') },
  -> { system('nodenv install -s 11.6.0') },
  -> { system('goenv install -s 1.11.4') },
  -> { system('rustup update') },
]

if installs.all?(&:call)
  system('rbenv global 2.6.2')
  system('pyenv global 3.7.2')
  system('nodenv global 10.15.3')
  system('goenv global 1.11.4')
  system('rustup default stable')

  system('bash -c "git clone git://github.com/concordusapps/pyenv-implict.git $(pyenv root)/plugins/pyenv-implict"')
  system('bash -c "git clone https://github.com/jawshooah/pyenv-default-packages.git $(pyenv root)/plugins/pyenv-default-packages"')

  require_relative './rust_packages'
else
  puts 'some installs failed, not setting globals'
end
