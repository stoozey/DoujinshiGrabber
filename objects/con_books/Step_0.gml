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
			global.waiting = (pagesLoaded < pagesTotal);
		
		bookListScroll = Ease(bookListScroll, bookListScrollReal, 0.25, EaseInOutSine);
	}break;
	
	case VIEW_STATE.BOOK_PAGES:
	{
		
	}break;
}