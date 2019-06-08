# frozen_string_literal: true

versions = {
  rbenv: '2.6.2',
  pyenv: '3.7.3',
  nodenv: '10.15.0',
  goenv: '1.11.4'
}

installs = [
  *versions.map { |k, v| -> { system("#{k} install -s #{v}") } },
  -> { system('pyenv install -s 2.7.15') },
  -> { system('nodenv install -s 11.6.0') },
  -> { system('rustup update') }
]

plugins = {
  '$(pyenv root)/plugins' => {
    'pyenv-implicit' => 'https://github.com/concordusapps/pyenv-implict.git',
    'pyenv-default-packages' => 'https://github.com/jawshooah/pyenv-default-packages.git'
  }
}

if installs.all?(&:call)
  versions.each { |k, v| system("#{k} global #{v}") }
  system('rustup default stable')

  plugins.each_key do |plugin_dir|
    system("mkdir -p #{plugin_dir}")

    plugins[plugin_dir].each do |name, remote|
      dest = File.join(plugin_dir, name)

      unless system("[[ -d \"#{dest}\" ]]")
        system("bash -c 'git clone \"#{remote}\" \"#{dest}\"'")
      end
    end
  end

  require_relative './rust_packages'
else
  puts 'some installs failed, not setting globals'
end
