///@desc get pages
global.waiting = true;

con_books.pagesTotal = totalPages;
for (var i = 0; i < totalPages; ++i)
{
    var _dest;
	_dest = book_dir_get_page(id, i, true);
	
	getPages[i] = http_get_file(pageUrls[i], _dest);
	debug("Downloading page #" + string(i) + " from " + pageUrls[i]);
}
