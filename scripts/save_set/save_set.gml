///@arg key
///@arg value
///@arg [parent_key]

var _save;
switch (file_exists(FILE_SAVE))
{
	case true: _save	= json_load(FILE_SAVE); break;
	case false: _save	= ds_map_create(); break;
}
switch (argument_count > 2)
{
	case false: ds_map_replace(_save, argument[0], argument[1]); break;
	
	case true:
		var _parentMap;
		switch (ds_map_exists(_save, argument[2]))
		{
			case true: _parentMap	= _save[? argument[2]]; break;
			case false: _parentMap	= ds_map_create(); break;
		}
		ds_map_replace(_parentMap, argument[0], argument[1]);
		ds_map_add_map(_save, argument[2], _parentMap);
		break;
}
json_save(FILE_SAVE, _save, ds_type_map);

ds_map_destroy(_save);

return argument[1];