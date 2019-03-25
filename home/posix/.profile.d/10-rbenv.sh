#shellcheck shell=sh

eval "$(rbenv init -)"

user_rubies() {
  for x in $(rbenv versions | cut -c 3- | awk '{print $1}')
  do
    if [ $x = "system" ]; then
      continue
    fi

    rbenv shell "$x"
    "$@"
  done
}
