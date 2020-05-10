var _totalPages;
_totalPages = array_length_1d(pageUrls);
for (var i = 0; i < _totalPages; ++i)
{
	if (async_load[? "id"] == getPages[i])
	{
		var _status;
		_status = async_load[? "status"];
		//if (_status < 0)
		//{
		//	//var _ext;
		//	//_ext = dir_get_ext(async_load[? "result"]);
		//	debug("PAGE #" + string(i) + " WAS NOT CREATED, CHANGING TO PNG");
			
		//	  var _dest;
		//	_dest = dir_make_png(book_dir_get_page(id, i, true));
	
		//	getPages[i] = http_get_file(pageUrls[i], _dest);
			
		//	continue;
		//}
		
		switch (_status == 0)
		{
			//	data has been downloaded
			case true:
			{
				global.downloading = false;
				pages[i] = sprite_add(async_load[? "result"], 0, false, false, 0, 0);
				
				with (con_books) { ++pagesLoaded; };
				debug("Loaded page #" + string(i));
			}break;
			
			//	data is downloading
			case false:
			{
				global.downloading = true;
				
				var _i;
				_i = (i + 1);
				dataDownloadCurrent[_i]	= async_load[? "sizeDownloaded"];
				dataDownloadTotal[_i]		= async_load[? "contentLength"];
			}break;
		}
	}
}

if (async_load[? "id"] == getCover)
{
	var _status;
	_status = async_load[? "status"];
	if (_status < 0)
	{
		debug("Book \"" + title + "\" had a problem downloading the cover.");
		book_delete(id);
		exit;
	}
	
	switch (_status == 0)
	{
		//	data has been downloaded
		case true:
		{
			global.downloading = false;
			cover = sprite_add(async_load[? "result"], 0, false, false, 0, 0);
			sprite_index = cover;
			with (con_books) { ++booksLoaded; };
		}break;
		
		//	data is downloading
		case false:
		{
			global.downloading = true;
			
			dataDownloadCurrent[0]	= async_load[? "sizeDownloaded"];
			dataDownloadTotal[0]			= async_load[? "contentLength"];
		}break;
	}
}