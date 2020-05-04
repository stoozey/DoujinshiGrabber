//	always call user event 0 when the ui element has been interacted with mb_left
enum UI_EVENT { PRESS, ANIM_ENTER, ANIM_EXIT, ANIM_PRESS, ANIM_NULL }
#macro UI_SCALE_DEFAULT		(0.9)
#macro UI_ALPHA_DEFAULT	(0.7)

scale	= UI_SCALE_DEFAULT;
alpha	= UI_ALPHA_DEFAULT;

if (uiUseAnimsScale)
	uiAnimScaleTween = TweenNull();

if (uiUseAnimsAlpha)
	uiAnimAlphaTween = TweenNull();

currentAnim	= UI_EVENT.ANIM_NULL;
isEntering		= false;
isLeaving			= false;
isPressing		= false;