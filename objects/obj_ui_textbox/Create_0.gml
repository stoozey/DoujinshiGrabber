event_inherited()

keyboardText	= "";
typebeam		= "";

if (isTags)
{
	xOffset = room_width - ( x + image_xscale);
	keyboardText = global.tags;
	text = keyboardText;
	keyboard_string = global.tags;
}

alarm[0] = room_speed;