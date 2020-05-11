gml_pragma("global", "__init()");

#region contants

#macro X			(0)
#macro Y			(1)
#macro DIR	(2)

#macro X1	(0)
#macro Y1	(1)
#macro X2	(2)
#macro Y2	(3)

#macro null	(undefined)

#macro mouse_x_gui	(device_mouse_x_to_gui(0))
#macro mouse_y_gui	(device_mouse_y_to_gui(0))

#macro debug show_debug_message

#macro SAT_DARKEST			(13)
#macro SAT_DARK				(31)
#macro SAT_NORMAL		(56)
#macro SAT_TEXT					(271)
#macro SAT_HIGHLIGHT	(162)

#macro FILE_SAVE	("config.cfg")

#macro ERROR_MSG_GRAB_FAIL ("An error occured when getting the data.\nPlease try again or try another query.")

//	where the book view starts on Y
#macro VIEW_Y (160)

#macro WINDOW_W_MIN	(1024)
#macro WINDOW_H_MIN		(768)

#macro COVER_W (WINDOW_W_MIN / 2.5)
#macro COVER_H (280)	//	good small: 280, good large: 400

#macro NAVBAR_HEIGHT	(33)

#macro BASE_W (1152)
#macro BASE_H (896)

#endregion

#region init code


var _hello;
_hello = "HELLO THERE! I see you like reading decompiled code. How is that going for you? Have you found anything cool? Probably not. Anyway, download jOeSU at https://stoozey.itch.io/joesu..... JUST KIDDING! You don't have to... unless... maybe... y-you will...?"

globalvar WINDOW;
WINDOW = [ window_get_width(), window_get_height() ];
var _dW, _dH;
_dW	= display_get_width();
_dH	= display_get_height();
if ((BASE_W >_dW))|| (BASE_H > _dH)
{
	var _w, _h;
	_w	= BASE_W - (BASE_W - _dW - 92);
	_h	= BASE_H - (BASE_H - _dH - 92);
	window_set_size(_w, _h);
	WINDOW = [ window_get_width(), window_get_height() ];
}

global.downloading	= false;	//	if we are downloading content
global.waiting				= false;	//	if we are waiting for scontent to be processed

globalvar DIR_TEMP;
DIR_TEMP = (temp_directory + "\\doujinshigrabber\\books\\");

globalvar BOOK_LIST;
BOOK_LIST = ds_list_create();

enum colour { darkest, dark, normal, text, highlight };
globalvar COL;
COL = array_create(colour.highlight + 1, c_black);

//	add japanese font
global.fontJpn = fnt_japan;
var _fontPath;
_fontPath = "data\\fonts\\KosugiMaru-Regular.ttf";
if (file_exists(_fontPath))
{
	global.fontJpn = font_add(_fontPath, 18, false, false, 32, 423);
	debug("loaded japanese font");
}
else
	show_message("Could not find Japanese font, expect \"▯\" symbols in-place of Japanese characters.");

#region	getting config data

#macro CFG_HUE						("colour_hue")
#macro CFG_TAGS					("tag_last")
#macro CFG_DIR_SAVE			("dir_save")
#macro CFG_WINDOW_W		("window_w")
#macro CFG_WINDOW_H		("window_h")
#macro CFG_LOW_BANDW		("low_bandwidth_mode")
////	@2.3 : UNCOMMENT CODE
////	defaults

#macro DIR_IMAGES_DEFAULT ("books\\")

////	saved stuff
//try
//{
	global.__cfgHue =  clamp(save_get(CFG_HUE, 214, null, "number"), 0, 255);
	global.__cfgTags =  save_get(CFG_TAGS, "", null, "string");
	global.__cfgDirImages = save_get(CFG_DIR_SAVE, DIR_IMAGES_DEFAULT, null, "string");
	global.__cfgLowBandwidth = bool(save_get(CFG_LOW_BANDW, 0, null, "number"));
	
	//var _w, _h;
	//_w = clamp(save_get(CFG_WINDOW_W, WINDOW_W_MIN, null, "number"), WINDOW_W_MIN, display_get_width());
	//_h = clamp(save_get(CFG_WINDOW_H, WINDOW_H_MIN, null, "number"), WINDOW_H_MIN, display_get_height());
	//window_set_size(_w, _h);
	//WINDOW = [ _w, _h ];
	//display_set_gui_size(_w, _h);
//}
//catch (e)
//{
	
//	global.__cfgHue			= 214;
//	global.__cfgTags			= "";
//	global.__cfgDirImages	= DIR_IMAGES_DEFAULT;
//	global.__cfgLowBandwidth = false;
	
//	if (file_exists(FILE_SAVE))
//	{
//		file_copy(FILE_SAVE, "config-corrupted.cfg");
//		file_delete(FILE_SAVE);
//		show_message("Your config was corrupted and has been reset.\n(Backed up to file \"config-corrupted.cfg\" for manual fixing.)";
//	}
//}

if (string_char_at(global.__cfgDirImages, string_length(global.__cfgDirImages)) != "\\")
	global.__cfgDirImages += "\\";

#endregion

#endregion