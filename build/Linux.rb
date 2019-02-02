#/usr/bin/env ruby

# frozen_string_literal: true

# note: assuming Fedora

def vscode
  repo = "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc"

  sys("sudo sh -c 'echo -e \"#{repo}\" > /etc/yum.repos.d/vscode.repo'")
end

def packages
  %w[
    xclip
    gnupg2
    java-11-openjdk
    code
    pinentry-gnome3
  ]
end

def software_groups
  [
    "'Development Tools'"
  ]
end

def commands
  [
    sys("sudo dnf upgrade -y"),
    sys("sudo yum groupinstall -y #{software_groups.join(" ")}"),
    sys("sudo dnf install -y #{packages.join(" ")}"),
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

