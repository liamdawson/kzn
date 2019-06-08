#!/usr/bin/env bash

set -euo pipefail

sudo dnf install -y @development-tools curl file git libxcrypt-compat
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
