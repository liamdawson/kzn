#!/usr/bin/env ruby

# frozen_string_literal: true

Dir["#{__dir__}/files/com.ldaws.*.plist"].each do |file|
  filename = File.basename(file)
  dest = "/Library/LaunchDaemons/#{filename}"
  system("sudo cp '#{file}' '#{dest}'")
  system("sudo launchctl unload -w '#{dest}'")
  system("sudo launchctl load -w '#{dest}'")
end

system("cp #{__dir__}/files/dnsmasq.Darwin.conf /usr/local/etc/dnsmasq.conf")
system("cp -r #{__dir__}/files/dnsmasq.d/ /usr/local/etc/dnsmasq.d/")

system('mkdir -p /usr/local/etc/caddy/')
system("cp #{__dir__}/files/sample.Caddyfile /usr/local/etc/caddy/Caddyfile") unless File.exist?('/usr/local/etc/caddy/Caddyfile')

system('bash -c "sudo brew services restart dnsmasq || sudo brew services start dnsmasq"')

system('sudo mkdir /etc/resolver') unless Dir.exist?('/etc/resolver')
system('bash -c \'echo "nameserver 127.0.0.1" | sudo tee /etc/resolver/test > /dev/null\'')
