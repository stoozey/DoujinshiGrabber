WINDOW = [ window_get_width(), window_get_height() ];

if (WINDOW[X] != display_get_gui_width()) || (WINDOW[X] != display_get_gui_width())
{
	WINDOW[X] = clamp(WINDOW[X], WINDOW_W_MIN, display_get_width());
	WINDOW[Y] = clamp(WINDOW[Y], WINDOW_H_MIN, display_get_height());
	window_set_size(WINDOW[X], WINDOW[Y]);
	
	with (obj_ui_textbox)
	{
		if (isTags)
		{
			image_xscale = WINDOW[X] - xstart - xOffset;
		}
	}
	
	display_set_gui_size(WINDOW[X], WINDOW[Y]);
}