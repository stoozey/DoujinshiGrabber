var _sat;
_sat	= 90;
COL[colour.darkest]	= make_colour_hsv(hue, _sat, SAT_DARKEST);
COL[colour.dark]			= make_colour_hsv(hue, _sat, SAT_DARK);
COL[colour.normal]		= make_colour_hsv(hue, _sat, SAT_NORMAL);
COL[colour.text]			= make_colour_hsv(hue, _sat, SAT_TEXT);
COL[colour.highlight]	= make_colour_hsv(hue, 215, SAT_HIGHLIGHT);

var _bgLayerID, _bgLayer;
_bgLayerID = layer_get_id("Background");
_bgLayer = layer_background_get_id(_bgLayerID);
layer_background_blend(_bgLayer, COL[colour.darkest]);