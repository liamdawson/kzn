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
    bzip2
    bzip2-devel
    openssl-devel
    libyaml-devel
    libffi-devel
    readline-devel
    zlib-devel
    gdbm-devel
    ncurses-devel
    sqlite-devel
    kitty
    docker-ce
    docker-ce-cli
    containerd.io
    telegram-desktop
    chromium
  ]
end

def software_groups
  [
    "'Development Tools'",
    "'Deepin Desktop'"
  ]
end

def commands
  [
    sys("sudo dnf upgrade -y"),
    sys("sudo dnf install -y dnf-plugins-core"),
    sys("sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-#{`rpm -E %fedora`}.noarch.rpm", !File.exist?("/etc/yum.repos.d/rpmfusion-free.repo")),
    *coprs.map {|copr| sys("sudo dnf copr enable -y #{copr}")},
    *repos.map {|repo| sys("sudo dnf config-manager --add-repo #{repo}")},
    sys("sudo yum groupinstall -y #{software_groups.join(" ")}"),
    sys("sudo dnf install -y #{packages.join(" ")}"),
  ].compact
end

def coprs
  %w[ oleastre/kitty-terminal ]
end

def repos
  %w[
    https://download.docker.com/linux/fedora/docker-ce.repo
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

