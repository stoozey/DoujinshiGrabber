#region searching for books and adding to book list
if (async_load[? "id"] == getSearch)
{
	switch (async_load[? "status"] == 0)
	{
		//	data has been downloaded
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
				
				var _totalBooks;
				_totalBooks = ds_list_size(_postList);
				for (var i = 0; i < _totalBooks; ++i)
				{
					var _thisPost, _postBookID, _postMediaID, _postTitle, _postPageCount;
					_thisPost			= _postList[| i];
					if (_thisPost == null) continue;
					
				    _postBookID			= _thisPost[? "id"];
				    _postMediaID			= _thisPost[? "media_id"];
					_postPageCount	= _thisPost[? "num_pages"];
					_postTitle					= ds_map_find_value(_thisPost[? "title"], "pretty");
					if (_postTitle == "") _postTitle = ds_map_find_value(_thisPost[? "title"], "english");
					if (_postTitle == "") _postTitle = ds_map_find_value(_thisPost[? "title"], "japanese");
					if (_postTitle == "") _postTitle = "Unknown book name";
					
					debug( "--" );
					debug(_postTitle);
					debug(_postBookID);
					debug( book_get_url_cover(_postMediaID) );
					debug( book_get_url_page(_postMediaID, 1) );
					
					var _book;
					_book = instance_create_depth(0, 0, 0, obj_container_book);
					with (_book)
					{
						title			= _postTitle;
						mediaID	= _postMediaID;
						bookID		= _postBookID;
						coverUrl	= book_get_url_cover(_postMediaID);
						
						pageUrls = array_create(_postPageCount);
						for (var o = 0; o < _postPageCount; ++o)
						    pageUrls[o] = book_get_url_page(_postMediaID, i);
						
						event_user(0);
					}
				}

				debug( "found " + string(_totalBooks) + " posts, out of " + string(_totalPages) + " total." );
			}
			else
				show_message("An error occured when getting the data. Please try again / try another query.");
			
			
			global.waiting = false;
		}break;
		
		//	we are still downloading data
		case false:
		{
			global.downloading = true;
			
			dataDownloadCurrent	= async_load[? "sizeDownloaded"];
			dataDownloadTotal			= async_load[? "contentLength"];
			
			debug( string(dataDownloadCurrent) + " / " + string(dataDownloadTotal));
		}break;
	}
}
#endregion