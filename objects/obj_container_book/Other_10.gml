///@desc get cover
if (getCover != -1) exit;

fileTypes = array_create(totalPages+1, FILE_TRIED.PNG);

var _cleanedTitle;
_cleanedTitle = string_clean(title);
dirImages = _cleanedTitle + "--" + uuid_generate();

var _dest;
_dest = book_dir_get_cover(id, true);

getCover = http_get_file(coverUrl, _dest);