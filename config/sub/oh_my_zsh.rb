# frozen_string_literal: true

require 'digest'

# Digest::SHA256

dest = File.join((ENV['XDG_DATA_DIR'] || "#{Dir.home}/.local/share"), "oh-my-zsh")
url = 'https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/078f64dcf9c56f45d1d5e9e49dd5709baedc1386/tools/install.sh'
checksum = 'de2120d2e85bd66b7cc4fdca0a5ec44d0aa951b6'

unless Dir.exist?(dest)
  script_dest = "#{Dir.home}/install-oh-my-zsh.sh"

  begin
    system("curl '#{url}' > '#{script_dest}'")
    abort('checksum failed for oh-my-zsh-install-script') unless Digest::SHA1.hexdigest(File.read(script_dest)) == checksum

    system("ZSH='#{dest}' sh #{script_dest} --unattended")
  ensure
    File.unlink(script_dest) if File.exist?(script_dest)
  end
end
