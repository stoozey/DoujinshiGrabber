///@desc buffer_save_string(filename, string)
///@arg filename
///@arg string

var _filename, _string;
_filename = argument0;
_string = argument1;

var _buffer;
_buffer = buffer_create(string_byte_length(_string)+1, buffer_fixed, 1);
buffer_write(_buffer, buffer_text, _string);
buffer_save(_buffer, _filename);
buffer_delete(_buffer);