///@desc react to inputs

if (ui_element_is_disabled()) exit;

isEntering	= (collision_point(mouse_x_gui, mouse_y_gui, id, false, false));
isLeaving		= (!isEntering);
isPressing	= ((isEntering) && (mouse_check_button_pressed(mb_left)));

var _labelCheck;
_labelCheck = (object_index == obj_ui_label);
_labelCheck = (_labelCheck) ? isLink : true;

if (isPressing) && (_labelCheck)
{
	cursor.selection = id;
	
	event_user(UI_EVENT.PRESS);
	event_user(UI_EVENT.ANIM_PRESS);
	
	exit;
}

if (isEntering)
{
	switch (object_index)
	{
		default:	window_set_cursor(cr_handpoint); break;
		
		case obj_ui_textbox: window_set_cursor(cr_beam); break;
		case obj_ui_label: if (isLink) window_set_cursor(cr_handpoint); break;
	}
	
	event_user(UI_EVENT.ANIM_ENTER);
}

if (isLeaving)
{
	event_user(UI_EVENT.ANIM_EXIT);
}