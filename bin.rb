#!/usr/bin/env ruby

# frozen_string_literal: true

@uname = `uname -s`.chomp.to_sym
commands = %w[ build brew config home cycle update shell code ]
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

def cycle
  build
  brew
  home
  config
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
  cycle
when 'update'
  cmd = "cd \"#{__dir__}\"; git pull https://github.com/liamdawson/kzn master"

  abort('failed') unless system("sh -c '#{cmd}'")

  (abort('failed') unless system("sh -c '#{__dir__}/kzn cycle'")) if ARGV[1] == 'now'
when 'push'
  cmd = "cd \"#{__dir__}\"; git push origin -u HEAD"

  abort('failed') unless system("sh -c '#{cmd}'")
when 'shell'
  Dir.chdir(__dir__) do
    system(ENV['SHELL'])
  end
when 'code'
  system(ENV['VISUAL'] || 'code', __dir__)
end
