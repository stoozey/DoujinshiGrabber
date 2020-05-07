///@desc get window size, set ui

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