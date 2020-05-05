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
				
				
				var _totalPosts;
				_totalPosts	= ds_list_size(_postList);
				for (var i = 0; i < _totalPosts; ++i)
				{
					var _thisPost, _postMediaID, _postTitle;
					_thisPost			= _postList[| i];
				    _postMediaID	= _thisPost[? "media_id"];
					_postTitle			= ds_map_find_value(_thisPost[? "title"], "pretty");
					
					debug(_postTitle);
				}
				debug( "found " + string(_totalPosts) + " posts" );
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