var _size;
_size = ds_list_size(BOOK_LIST);
for (var i = 0; i < _size; ++i)
{
	var _thisBook;
	_thisBook = BOOK_LIST[| i];
	instance_deactivate_object(_thisBook);
    instance_destroy(_thisBook);
}
ds_list_clear(BOOK_LIST);