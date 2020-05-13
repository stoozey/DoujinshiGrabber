for (var i = 0; i < totalPages; ++i)
{
	if (async_load[? "id"] == getPages[i])
	{
		var _status;
		_status = async_load[? "status"];
		if (_status < 0)
		{
			//var _ext;
			//_ext = dir_get_ext(async_load[? "result"]);

			
			continue;
		}
		
		switch (_status == 0)
		{
			//	data has been downloaded
			case true:
			{
				global.downloading = false;
				pages[i] = sprite_add(async_load[? "result"], 0, false, false, 0, 0);
				fileDirs[i+1] = async_load[? "result"];
				if (!sprite_exists(pages[i]))
				{
					var _scr;
					_scr = (fileTypes[i+1] == FILE_TRIED.PNG) ? dir_make_png : dir_make_jpeg;
					fileTypes[i+1]++;
					
					debug("PAGE #" + string(i) + " WAS NOT CREATED, CHANGING TO TYPE " + string(fileTypes[i+1]) );
					
					 var _dest;
					_dest = script_execute(_scr, book_dir_get_page(id, i, true));
					
					getPages[i] = http_get_file(script_execute(_scr, pageUrls[i]), _dest);
					exit;
				}
				
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
			fileDirs[0] = async_load[? "result"];
			if (!sprite_exists(cover))
			{
				var _scr;
				_scr = (fileTypes[0] == FILE_TRIED.PNG) ? dir_make_png : dir_make_jpeg;
				fileTypes[0]++;
				
				debug("COVER WAS NOT CREATED, CHANGING TO TYPE " + string(fileTypes[0]));
				
				 var _dest;
				_dest = script_execute(_scr, book_dir_get_page(id, i, true));
				
				getCover = http_get_file(script_execute(_scr, coverUrl), _dest);
				exit;
			}
			
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