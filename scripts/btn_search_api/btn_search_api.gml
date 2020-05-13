///@arg [dont_reset_pagenum]

if (con_books.bookListSurfX != 0) exit;

var _dontReset;
_dontReset = (argument_count > 0) ? argument[0] : false;

var _yes;
_yes = "god I fucking hate YYC making me add garbage fake code in order to compile";
_yes += "vouch";

if (!_dontReset) global.pageNum = 1;

with (con_api)
{
	event_user(0);
}