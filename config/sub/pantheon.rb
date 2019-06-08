def gsettings
  {
    'org.gnome.desktop.interface': {
      'gtk-theme' => 'elementary',
      'icon-theme' => 'elementary'
    }
  }
end

def commands
  [
    sys('echo configuring gnome'),
    *gsetting_commands(gsettings),
  ]
end

def sys(cmd)
  -> () { system(cmd) }
end

def gsetting_commands(settings)
  settings.flat_map do |namespace, settings|
    settings.map {|key, val| sys("gsettings set #{namespace} #{key} #{val}")}
  end
end

abort 'failed to configure gnome' unless commands.all? {|cmd| cmd.call}
