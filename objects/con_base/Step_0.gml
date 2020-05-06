#region resize window
if (mouse_check_button_released(mb_left))
	resizing = false;

var _mPos, _mPressed, _mHeld, _buff, _horizontal, _vertical, _resized;
_mPos			= [ mouse_x_gui, mouse_y_gui ];
_mPressed	= (mouse_check_button_pressed(mb_left));
_mHeld		= (mouse_check_button(mb_left));
_buff				= 6;
_horizontal	= ((_mPos[X] >= WINDOW[X] - _buff) ||  (_mPos[X] <= _buff));
_vertical		= ((_mPos[Y] >= WINDOW[Y] - _buff) || (_mPos[Y]<= _buff));

_resized = WINDOW;

if (_mPressed)
{
	resizeSize =  [ window_get_width(), window_get_height() ];
	resizing = true;
}

if (_horizontal) && (_vertical)
{
	if (_mPressed)
		resizePos = [ _mPos[X], _mPos[Y] ];
		
	_resized = [ resizeSize[X] + (mouse_x_gui - resizePos[X]), resizeSize[Y] + (mouse_y_gui - resizePos[Y]) ];
	window_set_cursor(cr_size_nwse);
}
else if (_horizontal)
{
	if (_mPressed)
		resizePos = [ _mPos[X], 0];
	
	_resized[X] = resizeSize[X] + (mouse_x_gui - resizePos[X]);
	window_set_cursor(cr_size_we);
}
else if (_vertical)
{
	if (_mPressed)
		resizePos = [ 0, _mPos[Y] ];
		
	_resized[Y] = resizeSize[Y] + (mouse_x_gui - resizePos[Y]);
	window_set_cursor(cr_size_ns);
}

if (resizing)
	window_set_size(_resized[X], _resized[Y]);

#endregion