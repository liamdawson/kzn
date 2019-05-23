installs = [
  -> { system('rbenv install -s 2.6.2') },
  -> { system('pyenv install -s 3.7.2') },
  -> { system('pyenv install -s 2.7.15') },
  -> { system('nodenv install -s 10.15.0') },
  -> { system('nodenv install -s 11.6.0') },
  -> { system('goenv install -s 1.11.4') },
  -> { system('rustup update') }
]

plugins = {
  '$(pyenv root)/plugins' => {
    'pyenv-implicit' => 'https://github.com/concordusapps/pyenv-implict.git',
    'pyenv-default-packages' => 'https://github.com/jawshooah/pyenv-default-packages.git'
  },
  '$(rbenv root)/plugins' => {
    'rbenv-chef-workstation' => 'https://github.com/docwhat/rbenv-chef-workstation.git'
  }
}

if installs.all?(&:call)
  system('rbenv global 2.6.2')
  system('pyenv global 3.7.2')
  system('nodenv global 10.15.3')
  system('goenv global 1.11.4')
  system('rustup default stable')

  plugins.each_key do |plugin_dir|
    system("mkdir -p #{plugin_dir}")

    plugins[plugin_dir].each do |name, remote|
      dest = File.join(plugin_dir, name)
      next if Dir.exist?(dest)

      system("bash -c 'git clone \"#{remote}\" \"#{dest}\"'")
    end
  end

  require_relative './rust_packages'
else
  puts 'some installs failed, not setting globals'
end
