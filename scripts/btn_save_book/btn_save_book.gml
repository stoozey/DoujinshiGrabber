var _book;
_book = con_books.bookSelected;
with (_book)
{
	var _dir;
	_dir = DIR_IMAGES + dirImages + "\\";
	directory_create(_dir);
	file_copy(fileDirs[0], book_dir_get_cover(id, false));
	for (var i = 0; i < totalPages; ++i)
	{
	    file_copy(fileDirs[i+1], book_dir_get_page(id, i, false));
	}
	isSaved = true;
}