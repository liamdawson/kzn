require_relative './sub/gnome' if ENV['XDG_SESSION_DESKTOP'] =~ /gnome/i
require_relative './sub/cinnamon' if ENV.key? 'CINNAMON_VERSION'
require_relative './sub/gpg_systemd'
