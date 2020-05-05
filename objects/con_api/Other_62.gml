if (async_load[? "id"] == getSearch)
{
	switch (async_load[? "status"] == 0)
	{
		//	data has been downloaded
		case true:
		{
			global.downloading = false;
			
			var _result;
			_result = async_load[? "result"];
			debug(string(_result));
			
			
			global.waiting = false;
		}break
		
		//	we are still downloading data
		case false:
		{
			dataDownloadCurrent	= async_load[? "sizeDownloaded"];
			dataDownloadTotal			= async_load[? "contentLength"];
			
			debug( string(dataDownloadCurrent) + " / " + string(dataDownloadTotal));
		}break;
	}
}