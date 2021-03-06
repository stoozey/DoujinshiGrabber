if (state == VIEW_STATE.NULL) exit;
if (booksTotal <= 0) exit;

switch (state)
{
	case VIEW_STATE.BOOK_LIST:
	{
		if (bookSelected == noone)
		{
			global.waiting = (booksLoaded < booksTotal);
			bookListScrollReal -= (mouse_wheel_up() - mouse_wheel_down()) * 38;
			bookListScrollReal = clamp(bookListScrollReal, 0, bookPageHeight);
		}
		else
		{
			var _checkForCompletion;
			_checkForCompletion = global.waiting;
			
			global.waiting = (pagesLoaded < pagesTotal);
			
			//	tween x to move book pages into view
			if (_checkForCompletion) && (!global.waiting)
			{
				bookListSurfXTween = TweenFire(
					id, EaseInOutCubic, 0, 1, 0, 0.7, "bookListSurfX", bookListSurfX, -WINDOW[X]
				);
				TweenAddCallbackUser(bookListSurfXTween, TWEEN_EV_FINISH, id, 2);
			}
		}
		
		bookListScroll = Ease(bookListScroll, bookListScrollReal, 0.25, EaseInOutSine);
	}break;
	
	case VIEW_STATE.BOOK_PAGES:
	{
		
	}break;
}