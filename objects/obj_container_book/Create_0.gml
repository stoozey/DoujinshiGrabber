// other stuff
menuID		= -1;	//	the index that the book is in the BOOK_LIST
dirImages	= "";	//	the folder name that the images are saved to (DIR_IMAGES + dirImages)

totalPages = 0;

//	sprite data
cover		= -1;
pages	= [];

//	metadata
title			= "";
mediaID	= null;
bookID		= null;

coverUrl	= "";
pageUrls	= [];

//	index 0 is the cover, onward are pages
dataDownloadCurrent	= [];
dataDownloadTotal			= [];

//	http stuff
getCover	= -1;
getPages	= [];

//drawing stuff
scale				= 1;
scaleTween	= TweenNull();