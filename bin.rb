#!/usr/bin/env ruby

# frozen_string_literal: true

uname = `uname -s`.chomp.to_sym
commands = %w[ build brew config home ]
platforms = {
  Darwin: %w[ all posix Darwin ],
  Linux: %w[ all posix Linux ],
}

input_command = ARGV[0].downcase

abort "#{uname} is not a supported platform." unless platforms.keys.include? uname
abort "expected one of the following as a subcommand: #{commands.join(", ")}" unless commands.include? input_command

case input_command
when 'build', 'config'
  platforms[uname].each do |platform|
    require_relative "./#{input_command}/#{platform}"
  end
when 'home'
  platforms[uname].each do |platform|
    cmd = "stow -d '#{File.join(__dir__, 'home')}' -t '#{ENV['HOME']}' -R --no-folding #{platform}"
    puts(cmd)
    abort($?) unless system(cmd)
  end
when 'brew'
  platforms[uname].each do |platform|
    cmd = "brew bundle install --file='#{File.join(__dir__, 'brewfiles', "#{platform}.Brewfile")}'"
    puts(cmd)
    abort($?) unless system(cmd)
  end
end
