def cargo_binary(name)
  system("command -v #{name} >/dev/null") || system("cargo install #{name}")
end
system('rustup component add rustfmt clippy rust-src rust-analysis rls')
%w[cargo-tree cargo-edit cargo-vendor].each { |name| cargo_binary(name) }
