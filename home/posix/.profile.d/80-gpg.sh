#!/usr/bin/env bash
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"

GPG_PATH="$(command -v gpg 2>/dev/null)"
GPG2_PATH="$(command -v gpg2 2>/dev/null)"

if [[ ! -z "${GPG2_PATH}" ]] && [[ ! -z "${GPG_PATH}" ]]
then
  alias gpg="${GPG2_PATH}"
fi

