///@desc start search for tag


global.waiting = true;
global.downloading = true;

var _url;
_url	= API_URL_SEARCH + global.tags + "&pid=" + string(global.pageNum);
getSearch = http_get(_url);
debug("started search for query: " + global.tags + " ~ URL: " + _url);
