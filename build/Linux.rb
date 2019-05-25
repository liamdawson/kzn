#!/usr/bin/env ruby

# frozen_string_literal: true

# note: assuming Fedora

def packages
  %w[
    xclip
    gnupg2
    java-11-openjdk
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
    snapd
  ]
end

def snaps
  [
    '--classic code',
    'snap-store'
  ]
end

def software_groups
  [
    "'Development Tools'",
    "'Pantheon Desktop'"
  ]
end

def commands
  [
    sys("sudo dnf upgrade -y"),
    sys("sudo dnf install -y dnf-plugins-core"),
    *repo_packages.map { |key, val| sys("sudo dnf install -y #{val}", !File.exist?(key)) },
    *coprs.map {|copr| sys("sudo dnf copr enable -y #{copr}")},
    *repos.map {|repo| sys("sudo dnf config-manager --add-repo #{repo}")},
    sys("sudo yum groupinstall -y #{software_groups.join(" ")}"),
    sys("sudo dnf install -y #{packages.join(" ")}"),
    *remote_packages.map { |check, pkg| sys("sudo dnf install -y #{pkg}", !File.exist?(check)) },
    sys('[[ -d /snap ]] || sudo ln -s /var/lib/snapd/snap /snap'),
    *snaps.map { |snap| sys("sudo snap install #{snap}") }
  ].compact
end

def coprs
  %w[oleastre/kitty-terminal]
end

def repos
  %w[
    https://download.docker.com/linux/fedora/docker-ce.repo
  ]
end

def repo_packages
  {
    '/etc/yum.repos.d/rpmfusion-free.repo' => "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-#{`rpm -E %fedora`.chomp}.noarch.rpm",
    '/etc/yum.repos.d/rpmfusion-nonfree.repo' => "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-#{`rpm -E %fedora`.chomp}.noarch.rpm",
  }
end

def remote_packages
  {
    '/opt/chef-workstation' => 'https://packages.chef.io/files/stable/chef-workstation/0.2.53/el/7/chef-workstation-0.2.53-1.el6.x86_64.rpm'
  }
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

