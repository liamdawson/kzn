#!/usr/bin/env ruby

# frozen_string_literal: true

Dir["#{__dir__}/files/com.ldaws.*.plist"].each do |file|
  filename = File.basename(file)
  dest = "/Library/LaunchDaemons/#{filename}"
  system("sudo cp '#{file}' '#{dest}'")
  system("sudo launchctl unload -w '#{dest}'")
  system("sudo launchctl load -w '#{dest}'")
end

system("mkdir -p /usr/local/etc/coredns/")
system("cp #{__dir__}/files/Corefile /usr/local/etc/coredns/Corefile")

system("mkdir -p /usr/local/etc/caddy/")
system("cp #{__dir__}/files/sample.Caddyfile /usr/local/etc/caddy/Caddyfile") unless File.exist?('/usr/local/etc/caddy/Caddyfile')
