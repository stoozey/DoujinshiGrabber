//	searching for books
#macro API_URL										("https://nhentai.net/api/")
#macro API_URL_SEARCH		(API_URL + "galleries/search?")

//	gathering cover from books
#macro API_URL_COVER						("https://t.nhentai.net/galleries/")
#macro API_URL_COVER_FILE_EXT		("cover.jpg")
//	gathering images from books
#macro _API_URL_IMAGE									("https://i.nhentai.net/galleries/")
#macro _API_URL_IMAGE_FILE_EXT				(".jpg")
#macro _API_URL_IMAGE_LOW						("https://t.nhentai.net/galleries/")
#macro _API_URL_IMAGE_FILE_EXT_LOW	("t.jpg")

global.lowBandwidth = global.__cfgLowBandwidth;

globalvar API_URL_IMAGE, API_URL_IMAGE_FILE_EXT;
API_URL_IMAGE					= (global.lowBandwidth) ? _API_URL_IMAGE_LOW : _API_URL_IMAGE;
API_URL_IMAGE_FILE_EXT	= (global.lowBandwidth) ? _API_URL_IMAGE_FILE_EXT_LOW : _API_URL_IMAGE_FILE_EXT;

global.tags				= global.__cfgTags;
global.pageNum	= 0;
global.pageMax		= 0;

dataDownloadCurrent	= 1;	//	how much data we have downloaded out of the total
dataDownloadTotal			= 1;	//	the total amount of data to be downloaded