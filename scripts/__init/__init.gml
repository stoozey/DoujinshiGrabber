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

#macro NAVBAR_HEIGHT	(33)

#macro WINDOW_W_MIN	(1024)
#macro WINDOW_H_MIN		(768)

#endregion

#region init code

globalvar WINDOW;
WINDOW = [ window_get_width(), window_get_height() ];

global.downloading	= false;	//	if we are downloading content
global.waiting				= false;	//	if we are waiting for scontent to be processed


enum colour { darkest, dark, normal, text, highlight };
globalvar COL;
COL = array_create(colour.highlight + 1, c_black);


#region	getting config data

#macro CFG_HUE		("colour_hue")
////	@2.3 : UNCOMMENT CODE
////	defaults
global.__cfgHue	= 0;

////	saved stuff
//try
//{
	global.__cfgHue =  clamp(save_get(CFG_HUE, 0, null, "number"), 0, 255);
//}
//catch (e)
//{
//	if (file_exists(FILE_SAVE))
//	{
//		file_copy(FILE_SAVE, "config-corrupted.cfg");
//		file_delete(FILE_SAVE);
//		show_message("Your config was corrupted and has been reset.\n(Backed up to file \"config-corrupted.cfg\" for manual fixing.)";
//	}
//}

#endregion

#endregion