function user_rubies
  for x in (rbenv versions | cut -c 3- | awk '{print $1}')
    if [ $x = "system" ]
      continue
    end

    rbenv shell "$x"
    $argv
  end
end
