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
			if (_result != null)
			{
				debug( string(_result) );
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