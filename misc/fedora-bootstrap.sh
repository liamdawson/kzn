#!/usr/bin/env bash

set -euo pipefail

sudo dnf install -y @development-tools curl file git libxcrypt-compat
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
mkdir ~/.kzn
curl -sSL https://github.com/liamdawson/kzn/archive/master.tar.gz | tar -xz --directory="$HOME/.kzn" --strip-components=1
~/.kzn/kzn cycle
