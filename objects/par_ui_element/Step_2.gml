///@desc reac tto inputs

if (ui_element_is_disabled()) exit;

isEntering	= (collision_point(mouse_x_gui, mouse_y_gui, id, false, false));
isLeaving		= (!isEntering);
isPressing	= ((isEntering) && (mouse_check_button_pressed(mb_left)));

if (isEntering)
{
	cursor.selection = id;
	event_user(UI_EVENT.ANIM_ENTER);
}

if (isLeaving)
{
	event_user(UI_EVENT.ANIM_EXIT);
}

if (isPressing)
{
	event_user(UI_EVENT.PRESS);
	event_user(UI_EVENT.ANIM_PRESS);
}