///@arg tween_type

if (ui_element_is_disabled()) exit;
if (currentAnim == UI_EVENT.ANIM_PRESS) exit;

#macro _SCALE		(0)
#macro _ALPHA	(1)

var _tweenType;
_tweenType	= argument0;

var _start, _end, _mode, _destroy, _time, _ease;
_mode		= TWEEN_MODE_ONCE;
_destroy	= false;
_time			= 0.22;
_ease		= uiAnimTweenScript;
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
		_start			= [ UI_SCALE_DEFAULT, alpha - 0.1 ];
		_end			= [ uiAnimScaleFull, 1 ];
		_mode		= TWEEN_MODE_BOUNCE;
		_destroy	= true;
		_time			= 0.1;
		_ease		= EaseInOutSine;
		break;
}
currentAnim	= _tweenType;

if (uiUseAnimsScale) && (/*(scale != _start[_SCALE]) &&*/ (scale != _end[_SCALE]))
{
	var _tweenExists;
	_tweenExists =  (TweenExists(uiAnimScaleTween));
	if (_destroy) && (_tweenExists)
	{
		TweenDestroy(uiAnimScaleTween);
		_tweenExists	= false;
	}
	
	if (!_tweenExists)
	{
		uiAnimScaleTween = TweenFire(id, _ease, _mode, true, 0, _time, "scale", _start[_SCALE], _end[_SCALE]);
		TweenAddCallbackUser(uiAnimScaleTween, TWEEN_EV_FINISH, id, UI_EVENT.ANIM_NULL);
	}
		
		//debug("ran scale tween, mode: " + string(_tweenType));
}

if (uiUseAnimsAlpha) && (/*(alpha != _start[_ALPHA]) && */(alpha != _end[_ALPHA]))
{
	var _tweenExists;
	_tweenExists =  (TweenExists(uiAnimAlphaTween));
	if (_destroy) && (_tweenExists)
	{
		TweenDestroy(uiAnimAlphaTween);
		_tweenExists	= false;
	}
	
	if (!_tweenExists)
	{
		uiAnimAlphaTween = TweenFire(id, _ease, _mode, true, 0, _time, "alpha", _start[_ALPHA], _end[_ALPHA]);
		TweenAddCallbackUser(uiAnimAlphaTween, TWEEN_EV_FINISH, id, UI_EVENT.ANIM_NULL);
	}
		
		//debug("ran alpha tween, mode: " + string(_tweenType));
}