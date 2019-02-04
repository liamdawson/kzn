bin_dir = File.join(ENV['HOME'], '.local', 'bin')
Dir.mkdir(bin_dir) unless File.exist?(bin_dir)

kzn_symlink_path = File.join(ENV['HOME'], '.local', 'bin', 'kzn')

File.symlink(File.join(__dir__, '..', 'kzn'), kzn_symlink_path) unless File.exist? kzn_symlink_path

system("curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path --default-toolchain stable -y") unless Dir.exist?(File.join(ENV['HOME'], '.rustup'))
