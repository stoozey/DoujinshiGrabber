///@arg key
///@arg default
///@arg [parent_key]
///@arg [typeof]

if (file_exists(FILE_SAVE))
{
	var _save, _value;
	_save = json_load(FILE_SAVE);
	switch(argument_count > 2)
	{
		case false:
			_value = _save[? argument[0]];
			break;
		
		case true:
			if (argument[2] == null)
				_value = _save[? argument[0]];
			else
			{
				var _parentMap;
				_parentMap	= _save[? argument[2]];
				_value				= _save[? argument[0]];
			}
			break;
	}
	
	ds_map_destroy(_save);
	
	if (_value == null)
	|| (argument_count > 3) && (typeof(_value) != argument[3]) 
		return argument[1];
	
	if (!is_undefined(_value))
		return _value;
}

return argument[1];