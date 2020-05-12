if (sprite_exists(cover))
	sprite_delete(cover);

for (var i = 0; i < totalPages; ++i)
{
    if (sprite_exists(pages[i]))
		sprite_delete(pages[i]);
}