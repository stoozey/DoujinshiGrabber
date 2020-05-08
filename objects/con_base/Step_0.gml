var _horizontal, _vertical, _buff;
_buff = 16;
_horizontal	= (mouse_x_gui >= (WINDOW[X] - _buff));
_vertical		= (mouse_y_gui >= (WINDOW[Y] - _buff));

if (_horizontal) && (_vertical)
{
	window_set_cursor(cr_size_nwse);
}
//else if (_horizontal)
//{
//	window_set_cursor(cr_size_we);
//}
//else if (_vertical)
//{
//	window_set_cursor(cr_size_ns);
//}