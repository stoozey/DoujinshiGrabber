//	always call user event 0 when the ui element has been interacted with mb_left
enum UI_EVENT { PRESS, ANIM_ENTER, ANIM_EXIT, ANIM_PRESS, ANIM_NULL }
#macro UI_SCALE_DEFAULT		(0.97)
#macro UI_ALPHA_DEFAULT	(0.7)

scale	= UI_SCALE_DEFAULT;
alpha	= UI_ALPHA_DEFAULT;
alphaAdjusted = alpha + (enabled / 10);

if (uiUseAnimsScale)
	uiAnimScaleTween = TweenNull();

if (uiUseAnimsAlpha)
	uiAnimAlphaTween = TweenNull();

currentAnim	= UI_EVENT.ANIM_NULL;
isEntering		= false;
isLeaving			= false;
isPressing		= false;

//if (object_index != obj_ui_label) && (desc != "")
//{
//	var _label;
//	_label = instance_create_depth(0, 0, 0, obj_ui_label);
//	_label.parent = id;
//	_label.image_xscale = 64;
//	_label.image_yscale = 32;
//	_label.text = desc;
//}