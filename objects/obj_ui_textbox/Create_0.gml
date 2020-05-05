event_inherited()

keyboardText	= "";
typebeam		= "";

if (isTags)
{
	xOffset = room_width - ( x + image_xscale);
	text = global.tags;
	keyboard_string = global.tags;
}

alarm[0] = room_speed;