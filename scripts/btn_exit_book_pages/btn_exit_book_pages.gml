with (con_books.bookSelected)
{
	for (var i = 0; i < totalPages; ++i)
	{
	    if (sprite_exists(pages[i]))
			sprite_delete(pages[i]);
	}
}

with (con_books)
{
	bookSelected = noone;
	
	bookListSurfXTween = TweenFire(
		id, EaseInOutCubic, 0, 1, 0, 0.7, "bookListSurfX", bookListSurfX, 0
	);
	TweenAddCallbackUser(bookListSurfXTween, TWEEN_EV_FINISH, id, 1);
	
	shaderRadiusTween = TweenFire(id, EaseOutSine, 0, 1, 0.5, 0.5, "shaderRadius", shaderRadius, 0);
}

mouse_clear(mb_left);