# Defined in - @ line 1
function dx --description 'alias dx=direnv exec .'
	direnv exec . $argv;
end
