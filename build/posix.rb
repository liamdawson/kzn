kzn_symlink_path = File.join(ENV['HOME'], '.local', 'bin', 'kzn')

File.symlink(File.join(__dir__, '..', 'kzn'), kzn_symlink_path) unless File.exist? kzn_symlink_path
