if (state == VIEW_STATE.NULL) exit;
if (booksTotal <= 0) exit;

switch (state)
{
	case VIEW_STATE.BOOK_LIST:
	{
		if (bookSelected == noone)
			global.waiting = (booksLoaded < booksTotal);
		else
			global.waiting = (pagesLoaded < pagesTotal);
		
		
		bookListScrollReal -= (mouse_wheel_up() - mouse_wheel_down()) * 32;
		bookListScrollReal = clamp(bookListScrollReal, 0, bookPageHeight);
		
		bookListScroll = Ease(bookListScroll, bookListScrollReal, 0.25, EaseInOutSine);
	}break;
	
	case VIEW_STATE.BOOK_PAGES:
	{
		
	}break;
}