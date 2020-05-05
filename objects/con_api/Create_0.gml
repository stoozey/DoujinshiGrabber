#macro API_URL						("https://nhentai.net/api/")
#macro API_URL_SEARCH		(API_URL + "galleries/search?query=")

global.tags				= global.__cfgTags;
global.pageNum	= 0;


dataDownloadCurrent	= 1;	//	how much data we have downloaded out of the total
dataDownloadTotal			= 1;	//	the total amount of data to be downloaded