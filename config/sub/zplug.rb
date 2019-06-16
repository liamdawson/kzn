# frozen_string_literal: true

dest = File.join((ENV['XDG_CONFIG_DIR'] || "#{Dir.home}/.config"), "zplug")
url = 'https://github.com/zplug/zplug.git'

unless Dir.exist?(dest)
  system("git clone '#{url}' '#{dest}'")
  system("zsh --interactive 'zplug install'")
end
