///@arg tween_type

if (ui_element_is_disabled()) exit;

#macro _SCALE		(0)
#macro _ALPHA	(1)

var _tweenType;
_tweenType	= argument0;

var _start, _end, _mode;
_mode = TWEEN_MODE_ONCE;
switch (_tweenType)
{
	default: _start = [ 1, 1 ]; _end = [ 1, 1]; break;
	
	case UI_EVENT.ANIM_ENTER:
		_start	= [ UI_SCALE_DEFAULT, UI_ALPHA_DEFAULT ];
		_end	= [ 1, 1 ];
		break;
	
	case UI_EVENT.ANIM_EXIT:
		_start	= [ 1, 1 ];
		_end	= [ UI_SCALE_DEFAULT, UI_ALPHA_DEFAULT ];
		break;
	
	case UI_EVENT.ANIM_PRESS:
		_start	= [ UI_SCALE_DEFAULT + 0.05, UI_ALPHA_DEFAULT + 0.1 ];
		_end	= [ 1.1, 1 ];
		_mode = TWEEN_MODE_BOUNCE;
		break;
}

if (uiUseAnimsScale)
{
	if (TweenExists(uiAnimScaleTween))
		TweenDestroy(uiAnimScaleTween);
	
	uiAnimScaleTween = TweenFire(id, uiAnimTweenScript, _mode, true, 0, 0.22, "scale", _start[_SCALE], _end[_SCALE]);
}

if (uiUseAnimsAlpha)
{
	if (TweenExists(uiAnimAlphaTween))
		TweenDestroy(uiAnimAlphaTween);
	
	uiAnimAlphaTween = TweenFire(id, uiAnimTweenScript, _mode, true, 0, 0.22, "alpha", _start[_ALPHA], _end[_ALPHA]);
}