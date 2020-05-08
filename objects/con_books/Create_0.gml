uData = shader_get_uniform(shd_blur_gaussian, "size");

enum VIEW_STATE { BOOK_LIST, BOOK_PAGES, NULL };
state						= VIEW_STATE.NULL;
surfBookList		= -1;	//	the surface containing the list of all search results
surfBookPages	= -1;	//	the surface containing the selected book and its appropriate page

bookListScroll				= 0;
bookListScrollReal	= 0;

booksTotal		= 0;
booksLoaded	= 0;

