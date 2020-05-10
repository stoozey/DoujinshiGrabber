///@desc get window size, set ui

#region resize window
//if (mouse_check_button_released(mb_left))
//	resizing = false;

//var _mPos, _mPressed, _mHeld, _buff, _horizontal, _vertical, _resized;
//_mPos			= [ display_mouse_get_x(), display_mouse_get_y() ];
//_mPressed	= (mouse_check_button_pressed(mb_left));
//_mHeld		= (mouse_check_button(mb_left));
//_buff				= 16;
//_horizontal	= (mouse_x_gui >= (WINDOW[X] - _buff));
//_vertical		= (mouse_y_gui >= (WINDOW[Y] - _buff));

//_resized = WINDOW;

//if (_mPressed)
//{
//	resizeSize =  [ window_get_width(), window_get_height() ];
//	resizing = true;
//}

//if (_horizontal) && (_vertical)
//{
//	if (_mPressed)
//		resizePos = [ _mPos[X], _mPos[Y] ];
		
//	_resized = [ resizeSize[X] + (_mPos[X] - resizePos[X]), resizeSize[Y] + (_mPos[Y] - resizePos[Y]) ];
//	window_set_cursor(cr_size_nwse);
//}
////else if (_horizontal)
////{
////	if (_mPressed)
////		resizePos = [ _mPos[X], 0];
	
////	_resized[X] = resizeSize[X] + (_mPos[X] - resizePos[X]);
////	window_set_cursor(cr_size_we);
////}
////else if (_vertical)
////{
////	if (_mPressed)
////		resizePos = [ 0, _mPos[Y] ];
		
////	_resized[Y] = resizeSize[Y] + (_mPos[Y] - resizePos[Y]);
////	window_set_cursor(cr_size_ns);
////}

//if (resizing)
//{
//	var _w, _h;
//	_w	= ( resizeSize[X] < WINDOW_W_MIN)	? WINDOW_W_MIN : _resized[X];
//	_h	= ( resizeSize[Y]< WINDOW_H_MIN)		? WINDOW_H_MIN : _resized[Y];
//	window_set_size(_w, _h);
//}

#endregion

WINDOW = [ window_get_width(), window_get_height() ];

if (WINDOW[X] != display_get_gui_width()) || (WINDOW[X] != display_get_gui_width())
{
	WINDOW[X] = clamp(WINDOW[X], WINDOW_W_MIN, display_get_width());
	WINDOW[Y] = clamp(WINDOW[Y], WINDOW_H_MIN, display_get_height());
	window_set_size(WINDOW[X], WINDOW[Y]);
	
	#region adjust ui elements to new window size
	with (obj_ui_textbox)
	{
		if (isTags)
		{
			image_xscale = WINDOW[X] - xstart - xOffset;
		}
	}
	
	with (obj_ui_button)
	{
		if (isGoButton)
		{
			var _pos;
			with (anchorOwner) { _pos = x + image_xscale; };
			x = _pos + 16;
		}
	}
	
	with (con_books)
	{
		if (surface_exists(surfBookList))
			surface_resize(surfBookList, WINDOW[X], WINDOW[Y] - VIEW_Y);
		if (surface_exists(surfBookPages))
			surface_resize(surfBookPages, WINDOW[X], WINDOW[Y] - VIEW_Y);
	}
	#endregion
	
	display_set_gui_size(WINDOW[X], WINDOW[Y]);
}