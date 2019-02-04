#!/usr/bin/env ruby

# frozen_string_literal: true

@uname = `uname -s`.chomp.to_sym
commands = %w[ build brew config home cycle update ]
@platforms = {
  Darwin: %w[ all posix Darwin ],
  Linux: %w[ all posix Linux ],
}

input_command = (ARGV[0] || '').downcase

abort "#{uname} is not a supported platform." unless @platforms.keys.include? @uname
abort "expected one of the following as a subcommand: #{commands.join(", ")}" unless commands.include? input_command

def build
  @platforms[@uname].each do |platform|
    require_relative "./build/#{platform}"
  end
end

def config
  @platforms[@uname].each do |platform|
    require_relative "./config/#{platform}"
  end
end

def home
  @platforms[@uname].each do |platform|
    cmd = "stow -d '#{File.join(__dir__, 'home')}' -t '#{ENV['HOME']}' -R --no-folding #{platform}"
    puts(cmd)
    abort('failed') unless system(cmd)
  end
end

def brew
  @platforms[@uname].each do |platform|
    cmd = "brew bundle install --file='#{File.join(__dir__, 'brewfiles', "#{platform}.Brewfile")}'"
    puts(cmd)
    system(cmd)
    # abort('failed') unless system(cmd)
  end
end

case input_command
when 'build'
  build
when 'config'
  config
when 'home'
  home
when 'brew'
  brew
when 'cycle'
  build
  brew
  home
  config
when 'update'
  cmd = "cd \"#{__dir__}\"; git pull"

  abort('failed') unless system("sh -c '#{cmd}'")
end

