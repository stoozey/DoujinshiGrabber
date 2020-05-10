global.lowBandwidth = !global.lowBandwidth;

API_URL_IMAGE					= (global.lowBandwidth) ? _API_URL_IMAGE_LOW						: _API_URL_IMAGE;
API_URL_IMAGE_FILE_EXT	= (global.lowBandwidth) ? _API_URL_IMAGE_FILE_EXT_LOW	: _API_URL_IMAGE_FILE_EXT;