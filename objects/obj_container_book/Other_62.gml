var _totalPages;
_totalPages = array_length_1d(pageUrls);
for (var i = 0; i < _totalPages; ++i)
{
	if (async_load[? "id"] == getPages)
	{
		switch (async_load[? "status"] == 0)
		{
			//	data has been downloaded
			case true:
			{
				global.downloading = false;
				
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
	switch (async_load[? "status"] == 0)
	{
		//	data has been downloaded
		case true:
		{
			global.downloading = false;
			cover = sprite_add(async_load[? "result"], 0, false, false, 0, 0);
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