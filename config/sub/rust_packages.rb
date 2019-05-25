def cargo_binary(name, check_for: nil)
  check_for ||= name
  system("command -v #{check_for} >/dev/null") || system("cargo install #{name}")
end
system('rustup component add rustfmt clippy rust-src rust-analysis rls')

%w[
  cargo-tree
  cargo-vendor
].each { |name| cargo_binary(name) }

{
  'cargo-edit': 'cargo-add'
}.each { |key, val| cargo_binary(key, check_for: val) }
