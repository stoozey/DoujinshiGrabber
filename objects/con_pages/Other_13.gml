///@desc tween alpha OUT
if (TweenExists(tweenAlpha))
	TweenDestroy(tweenAlpha);

tweenAlpha = TweenFire(id, EaseOutSine, 0, 1, 0, 0.1, "alpha", 1, 0);
TweenAddCallbackUser(tweenAlpha, TWEEN_EV_FINISH, id, 2);