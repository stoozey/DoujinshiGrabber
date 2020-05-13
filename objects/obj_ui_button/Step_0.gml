// Inherit the parent event
event_inherited();

var _book;
_book = con_books.bookSelected;
if (uiOffset) && (object_index == obj_ui_button) && (_book != noone)
{
	enabled = (!_book.isSaved);
}