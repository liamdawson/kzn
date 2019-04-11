#!/usr/bin/env bash

if [[ -x "$(command -v fzf)" ]]; then
  eval "$(fw print-"$(basename "$SHELL")"-setup -f 2>/dev/null)"
else
  eval "$(fw print-"$(basename "$SHELL")"-setup 2>/dev/null)"
fi
