if (sprite_exists(cover))
	sprite_delete(cover);

var _totalPages;
_totalPages = array_length_1d(pages);
for (var i = 0; i < _totalPages; ++i)
{
    if (sprite_exists(pages[i]))
		sprite_delete(pages[i]);
}