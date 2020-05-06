//	clean a string of any illegal characters
///@arg string

var _str;
_str = argument0;

_str = string_replace(_str, "[", "");
_str = string_replace(_str, "]", "");
_str = string_replace(_str, "\\", "");
_str = string_replace(_str, "/", "");
_str = string_replace(_str, "<", "");
_str = string_replace(_str, ">", "");
_str = string_replace(_str, ":", "");
_str = string_replace(_str, "\"", "");
_str = string_replace(_str, "|", "");
_str = string_replace(_str, "?", "");
_str = string_replace(_str, "*", "");
//_str = string_replace(_str, " ", "_");

return _str;