#/usr/bin/env ruby

# frozen_string_literal: true

# note: assuming apt-based system

def packages
  %w[
    gnome-session
    build-essential
    curl
    libgconf-2-4
    scdaemon
    git
    zlib1g-dev
  ]
end

def commands
  [
    sys("sudo apt update -y"),
    sys("sudo apt upgrade -y"),
    sys("sudo apt install -y #{packages.join(" ")}"),
    -> () do
      if command_exists('code')
        true
      else
        [
          sys("curl -sSLo /tmp/code.deb https://go.microsoft.com/fwlink/?LinkID=760868"),
          sys("sudo dpkg -i /tmp/code.deb"),
        ].all? { |cmd| cmd.call }
      end
    end,
  ]
end

def command_exists(cmd)
  `sh -c 'command -v #{cmd}'`.chomp.size.>(0)
end

def sys(cmd, toggle = true)
  -> do
    if toggle
      puts cmd
      system(cmd)
    else
      puts "skipping #{cmd}"
      true
    end
  end
end

abort("failed to run all commands") unless commands.all? { |cmd| cmd.call }
