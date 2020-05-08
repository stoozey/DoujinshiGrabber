///@arg book_id

var _book;
_book	= argument0;

ds_list_delete(BOOK_LIST, _book.menuID);

debug("##### Deleted book: " + _book.title);

with (_book) { instance_destroy(); };
with (con_books) { --booksTotal; };

return true;