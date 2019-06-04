platform = `uname -s`.chomp.to_sym

packages = {
  'coredns': {
    Darwin: 'https://github.com/coredns/coredns/releases/download/v1.5.0/coredns_1.5.0_darwin_amd64.tgz',
    Linux: 'https://github.com/coredns/coredns/releases/download/v1.5.0/coredns_1.5.0_linux_amd64.tgz',
    install: ->(url, destination) {
      system("curl -fsSL #{url} | tar -xz --directory=\"#{destination}\" coredns")
    }
  },
  'caddy': {
    Darwin: 'https://github.com/mholt/caddy/releases/download/v1.0.0/caddy_v1.0.0_darwin_amd64.zip',
    Linux: 'https://github.com/mholt/caddy/releases/download/v1.0.0/caddy_v1.0.0_linux_amd64.tar.gz',
    install: ->(url, destination) {
      system("curl -fsSL #{url} | tar -xz --directory=\"#{destination}\" caddy")
    }
  },
}

packages.each_key do |package|
  next if system("command -v #{package} >/dev/null")

  src = packages.dig(package, platform)
  dest = if platform == :Darwin
           '/usr/local/bin'
         else
           '${HOME}/.local/bin'
         end

  if src.nil?
    puts "warning: #{package} has no source for #{platform}, skipping"
    next
  end

  puts "installing #{package} for #{platform}"

  packages.dig(package, :install).call(src, dest)
end
