///@desc get cover

if (getCover != -1) exit;

var _cleanedTitle;
_cleanedTitle = string_clean(title);
dirImages = _cleanedTitle + "--" + uuid_generate();

var _dest;
_dest = book_dir_get_cover(id, true);

getCover = http_get_file(coverUrl, _dest);