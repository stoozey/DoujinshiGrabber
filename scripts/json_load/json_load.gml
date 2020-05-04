///@desc json_load(filename)
///@arg filename

var _filename;
_filename = argument0;

var _buffer, _string, _root, _json;

_buffer = buffer_load(_filename);
_string = buffer_read(_buffer, buffer_string);
buffer_delete(_buffer);

_root = json_decode(_string);
_json = _root[? "ROOT"];
_root[? "ROOT"] = undefined;
ds_map_destroy(_root);

return _json;