///@desc set book

var _book;
_book = con_books.bookSelected;

if (_book == noone) exit;

var _pages, _totalPages;
_pages			= _book.pages;
_totalPages	= _book.totalPages;

pages = [];
array_copy(pages, 0,_pages, 0, _totalPages);
totalPages = _totalPages;

pageIndex			= 0;
pageIndexReal	= 0;

event_user(3);