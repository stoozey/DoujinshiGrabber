if (!enabled) || (global.downloading) || (cursor.selection != id) exit;

keyboardText	= keyboard_string;
text					= keyboardText + typebeam;

if (isTags)
	global.tags = keyboardText;