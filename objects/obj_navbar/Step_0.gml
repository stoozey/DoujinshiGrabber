var _mPos;
_mPos = [ mouse_x_gui, mouse_y_gui ];
if (_mPos[Y] <= NAVBAR_HEIGHT)
{
	if (mouse_check_button_pressed(mb_left))
	{
		dragging = true;
		mxO	= _mPos[X]
		myO	= _mPos[Y]
	}
	
	 isHoveringOnX = (_mPos[X] >= WINDOW[X] - 64);
	 if (isHoveringOnX)
	 {
		 isHoveringOnX = true;
		 if (mouse_check_button_pressed(mb_left))
			game_end();
	 }

} else { isHoveringOnX = false; };

if (dragging)
{
	var mx, my;
	mx = display_mouse_get_x();
	my = display_mouse_get_y();

	window_set_position(mx - mxO, my - myO);

	if (mouse_check_button_released(mb_left))
		dragging = false;
}