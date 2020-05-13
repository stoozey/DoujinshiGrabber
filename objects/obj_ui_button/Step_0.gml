// Inherit the parent event
event_inherited();

var _book;
_book = con_books.bookSelected;
if (uiOffset) && (_book != noone)
{
	enabled = (!_book.isSaved);
}