///@desc start search for tag

global.waiting = true;
global.downloading = true;

getSearch = http_get(API_URL_SEARCH + global.tags);