///@arg menuID
///@arg title
///@arg mediaID
///@arg bookID
///@arg pageCount

var _menuID, _postTitle, _postMediaID, _postBookID, _postPageCount;
_menuID					= argument0;
_postTitle					= argument1;
_postMediaID			= argument2;
_postBookID			= argument3;
_postPageCount	= argument4;

var _book;
_book = instance_create_depth(0, 0, 0, obj_container_book);
with (_book)
{
	menuID	=_menuID;
	
	title			= _postTitle;
	mediaID	= _postMediaID;
	bookID		= _postBookID;
	coverUrl	= book_get_url_cover(_postMediaID);
	
	dataDownloadCurrent = array_create(_postPageCount + 1);
	dataDownloadTotal		= array_create(_postPageCount + 1);
	pageUrls = array_create(_postPageCount);
	for (var o = 0; o < _postPageCount; ++o)
	    pageUrls[o] = book_get_url_page(_postMediaID, o);
	
	event_user(0);
}

enum BOOK_IND { CONTAINER,	XX,	YY, SCALE };
ds_list_add(BOOK_LIST, [ _book, 0, 0, 1 ] );

debug("##### Created book: " + _postTitle);

return _book;