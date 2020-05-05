///@arg media_id
///@arg page_num

// page num starts at 1

var _page;
_page = string( ((argument1 <= 0) ? 1 : argument1) );

return (API_URL_IMAGE+ argument0 + "/" + _page + API_URL_IMAGE_FILE_EXT);