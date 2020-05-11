///@desc start search for tag

global.waiting = true;
global.downloading = true;

books_clear();

var _url;
_url	= API_URL_SEARCH + "page=" + string(global.pageNum) + "&query=" +  global.tags;
getSearch = http_get(_url);
debug("started search for query: " + global.tags + " ~ URL: " + _url);

get_image_dir(true);