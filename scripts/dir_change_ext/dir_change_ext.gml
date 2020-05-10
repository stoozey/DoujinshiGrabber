///@arg dir
///@arg ext
var _str, _ext;
_str = argument0;
_ext = argument1;

var _newStr;
_newStr = (string_delete(_str, string_length(_str)-3, 4)) + "." + _ext;

return _newStr;