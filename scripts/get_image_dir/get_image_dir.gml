///@arg [show_error_msg]

var _showMsg;
_showMsg = (argument_count > 0) ? argument[0] : false;

if (string_char_at(DIR_IMAGES, string_length(DIR_IMAGES)) != "\\")
	DIR_IMAGES += "\\";


var _saveDir, _errorMsg;
_saveDir = DIR_IMAGES;
_errorMsg = "\nUntil you change this, you can find your images in %localappdata%\\" + game_project_name + "\\" + DIR_IMAGES_DEFAULT;


 if (DIR_IMAGES == DIR_IMAGES_DEFAULT)
{
	_saveDir = DIR_IMAGES_DEFAULT;
	if (_showMsg)
	{
		show_message("Your image save directory is currently set to the default value." + 
		_errorMsg);
	}
}
else if (string_pos(program_directory, DIR_IMAGES) != 0)
{
	_saveDir = DIR_IMAGES_DEFAULT;
	
	if (_showMsg)
	{
		show_message("Your image save directory cannot be the folder or a sub-folder of this programs directory." + 
		_errorMsg);
	}
}
else if (!directory_exists(DIR_IMAGES))
{
	_saveDir = DIR_IMAGES_DEFAULT;
	if (_showMsg)
	{
		show_message("Your image save directory does not exist." + 
		_errorMsg);
	}
}

return _saveDir;