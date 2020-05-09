///@arg book_id
with (argument0)
{
	if (scale != 1) && (!TweenExists(scaleTween))
		scaleTween = TweenFire(id, EaseOutCubic, 0, true, 0, 0.2, "scale", 1.05, 1);
}