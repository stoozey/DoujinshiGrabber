///@desc get pages
global.waiting = true;
var _totalPages;
_totalPages = array_length_1d(pageUrls);
con_books.pagesTotal = _totalPages;
for (var i = 0; i < _totalPages; ++i)
{
    var _dest;
	_dest = book_dir_get_page(id, i, true);
	
	getPages[i] = http_get_file(pageUrls[i], _dest);
	debug("Downloading page #" + string(i) + " to " + _dest);
}
