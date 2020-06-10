// Inherit the parent event
event_inherited();

var _book;
_book = con_books.bookSelected;
if ((!global.waiting) && (object_index == obj_ui_button) && (uiOffset) && (_book != noone))
{
	enabled = (!_book.isSaved);
}