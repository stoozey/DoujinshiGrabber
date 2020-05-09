#region searching for books and adding to book list
if (async_load[? "id"] == getSearch)
{
	switch (async_load[? "status"] == 0)
	{
		#region	data has been downloaded
		case true:
		{
			global.downloading = false;
			
			var _result;
			_result = json_decode(async_load[? "result"]);
			if (_result != null)
			{
				var _postList, _totalPages, _postsPerPage;
				_postList				= _result[? "result"];
				_totalPages			= _result[? "num_pages"];
				_postsPerPage	= _result[? "per_page"];
				
				if (_postList == null)
				{
					show_message(ERROR_MSG_GRAB_FAIL);
					global.waiting = false;
					exit;
				}
				
				var _totalBooks;
				_totalBooks = ds_list_size(_postList);
				for (var i = 0; i < _totalBooks; ++i)
				{
					var _thisPost, _postBookID, _postMediaID, _postTitle, _postPageCount;
					_thisPost			= _postList[| i];
					
				    _postBookID			= _thisPost[? "id"];
				    _postMediaID			= _thisPost[? "media_id"];
					_postPageCount	= _thisPost[? "num_pages"];
					_postTitle					= ds_map_find_value(_thisPost[? "title"], "pretty");
					if (_postTitle == "") _postTitle = ds_map_find_value(_thisPost[? "title"], "english");
					if (_postTitle == "") _postTitle = ds_map_find_value(_thisPost[? "title"], "japanese");
					if (_postTitle == "") _postTitle = "Unknown book name";
					
					//debug( "--" );
					//debug(_postTitle);
					//debug(_postBookID);
					//debug( book_get_url_cover(_postMediaID) );
					//debug( book_get_url_page(_postMediaID, 1) );
					
					book_create(i, _postTitle, _postMediaID, _postBookID, _postPageCount);
				}
				debug( "found " + string(_totalBooks) + " posts, out of " + string(_totalPages) + " total." );
				global.pageMax = ceil(_totalPages / _totalBooks);
				debug("page count: " + string(global.pageMax) );
				
				//	give book controller info for drawing
				with (con_books)
				{
					state				= VIEW_STATE.BOOK_LIST;
					booksTotal	= _totalBooks;
				}
			}
			else
			{
				show_message(ERROR_MSG_GRAB_FAIL);
				global.waiting = false;
			}
			
		}break;
		#endregion
		
		#region	we are still downloading data
		case false:
		{
			global.downloading = true;
			
			dataDownloadCurrent	= async_load[? "sizeDownloaded"];
			dataDownloadTotal			= async_load[? "contentLength"];
			
			debug( string(dataDownloadCurrent) + " / " + string(dataDownloadTotal));
		}break;
		#endregion
	}
}
#endregion