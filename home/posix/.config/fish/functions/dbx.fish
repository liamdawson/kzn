# Defined in - @ line 1
function dbx --description 'alias dbx=direnv exec . bundle exec'
	direnv exec . bundle exec $argv;
end
