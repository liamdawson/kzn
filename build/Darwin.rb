#!/usr/bin/env ruby

# frozen_string_literal: true

corefile_dest = '/usr/local/etc/coredns/Corefile'

sh_cmd = "cmp -s '#{__dir__}/files/Corefile' '#{corefile_dest}' " \
         " || sudo cp '#{__dir__}/files/Corefile' '#{corefile_dest}'"
system('sh -c "' + sh_cmd + '"')
