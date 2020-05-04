///@desc json_save(filename, json, type)
///@arg filename
///@arg json
///@arg type

var _filename, _json, _type;
_filename	= argument0;
_json		= argument1;
_type		= argument2;

if (_type != ds_type_list) && (_type != ds_type_map)
	return false;

var _root, _string;
_root = ds_map_create();
if (_type == ds_type_list) ds_map_add_list(_root, "ROOT", _json);
else if (_type == ds_type_map) ds_map_add_map(_root, "ROOT", _json);

_string = json_encode(_root);
buffer_save_string(_filename, _string);

_root[? "ROOT"] = undefined;
ds_map_destroy(_root);
return true;