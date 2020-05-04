///@desc reac tto inputs

if (ui_element_is_disabled()) exit;

var _isEntering, _isLeaving, _isPressing;
_isEntering	= (collision_point(mouse_x_gui, mouse_y_gui, id, false, false));
_isLeaving	= (!_isEntering);
_isPressing	= ((_isEntering) && (mouse_check_button(mb_left)));

if (_isEntering)	event_user(UI_EVENT.ANIM_ENTER);
if (_isLeaving)		event_user(UI_EVENT.ANIM_EXIT);
if (_isPressing)	event_user(UI_EVENT.ANIM_PRESS);