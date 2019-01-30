launchctl_path = `launchctl getenv PATH`.chomp

if launchctl_path.empty?
  system 'bash -c "sudo launchctl config user path \"/usr/local/bin:$PATH\""'
end
