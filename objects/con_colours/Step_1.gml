if (hue != -1) && (hue == hueNew) exit;

if (!TweenExists(hueTween))
{
	hueTween = TweenFire(id, EaseInOutCubic, 0, true, 0, 0.5, "hue", hue, hueNew);
}

hue = round(hue);
var _sat;
_sat	= 16;
COL[colour.darkest]	= make_colour_hsv(hue, _sat, SAT_DARKEST);
COL[colour.dark]			= make_colour_hsv(hue, _sat, SAT_DARK);
COL[colour.normal]		= make_colour_hsv(hue, _sat, SAT_NORMAL);
COL[colour.text]			= make_colour_hsv(hue, _sat, SAT_TEXT);
COL[colour.highlight]	= make_colour_hsv(hue, 215, SAT_HIGHLIGHT);