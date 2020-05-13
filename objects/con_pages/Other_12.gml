///@desc tween & scale IN
scale = 1;

var _spr, _w, _h, _wMin, _hMin;
_spr	= pages[pageIndexReal];
_w		= sprite_get_width(_spr);
_h		= sprite_get_height(_spr);

_wMin = WINDOW[X] * 0.7;
_hMin = (WINDOW[Y] - VIEW_Y) * 0.7;

while (_w * scale >= _wMin)
	scale -= 0.001;

while (_h * scale >= _hMin)
	scale -= 0.001;

if (TweenExists(tweenSize))
	TweenDestroy(tweenSize);
if (TweenExists(tweenAlpha))
	TweenDestroy(tweenAlpha);

tweenSize = TweenFire(id, EaseInOutCubic, 0, 1, 0, 0.4,
	"backWidth", backWidth, _w * scale, "backHeight", backHeight, _h * scale
);
TweenAddCallbackUser(tweenSize, TWEEN_EV_FINISH, id, 1);
tweenAlpha = TweenFire(id, EaseInSine, 0, 1, 0.4, 0.1, "alpha", 0, 1);