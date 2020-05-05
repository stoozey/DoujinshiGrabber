if (hue == hueNew) exit;

if (!TweenExists(hueTween))
{
	hueTween = TweenFire(id, EaseInOutCubic, 0, true, 0, 0.5, "hue", hue, hueNew);
}

hue = round(hue);

colours_generate();