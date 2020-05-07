//	searching for books
#macro API_URL										("https://nhentai.net/api/")
#macro API_URL_SEARCH		(API_URL + "galleries/search?")

//	gathering cover from books
#macro API_URL_COVER						("https://t.nhentai.net/galleries/")
#macro API_URL_COVER_FILE_EXT		("cover.jpg")
//	gathering images from books
#macro API_URL_IMAGE						("https://i.nhentai.net/galleries/")
#macro API_URL_IMAGE_FILE_EXT		(".jpg")

global.tags				= global.__cfgTags;
global.pageNum	= 0;
global.pageMax		= 0;

//BOOK_LIST index  container id  cover http req	page http req
enum BOOK_IND { CONTAINER,	GET_COVER,	GET_PAGE };

dataDownloadCurrent	= 1;	//	how much data we have downloaded out of the total
dataDownloadTotal			= 1;	//	the total amount of data to be downloaded