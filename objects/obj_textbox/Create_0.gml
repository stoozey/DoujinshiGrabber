text = "";


typebeam = "";
alarm[0] = room_speed;

image_alpha = 0.7;

tween = TweenNull();

if (isTags)
{
	text = save_get("tag_last", "", null, "string");
	starScale = 0;
	starTween = TweenNull();
	arrowDir = 0;
	arrowTween = TweenNull();
}