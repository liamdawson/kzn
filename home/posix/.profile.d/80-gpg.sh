export GPG_TTY="$(tty)"

GPG_PATH="$(command -v gpg 2>/dev/null)"
GPG2_PATH="$(command -v gpg2 2>/dev/null)"

if [[ ! -z "${GPG2_PATH}" ]] && [[ ! -z "${GPG2_PATH}" ]]
then
  alias gpg="${GPG2_PATH}"
fi
