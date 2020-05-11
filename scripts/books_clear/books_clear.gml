var _size;
_size = ds_list_size(BOOK_LIST);
for (var i = 0; i < _size; ++i)
{
	var _thisBook;
	_thisBook = book_get_container(i);
	
	with (_thisBook)
	{
		if (sprite_exists(cover))
			sprite_delete(cover);
		
		var _totalPages;
		_totalPages = array_length_1d(pages);
		for (var o = 0; o < _totalPages; ++o)
		{
		    if (sprite_exists(pages[o]))
				sprite_delete(pages[o]);
		}
		instance_destroy();
	}
}
ds_list_clear(BOOK_LIST);

with (con_books)
{
	booksTotal		= 0;
	booksLoaded	= 0;
	state					= VIEW_STATE.NULL;
	
	bookListScroll				= 0;
	bookListScrollReal	= 0;
	listHasDeterminedPositions = false;
	
	if (surface_exists(surfBookList))
		surface_free(surfBookList);
	
	if (surface_exists(surfBookPages))
		surface_free(surfBookPages);
}