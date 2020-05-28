if (introAlpha > 0)
	draw_sprite_ext(spr_pixel, 0, 0, 0, WINDOW[X], WINDOW[Y], 0, COL[colour.darkest], introAlpha);

draw_9slice(0, 0, WINDOW[X], NAVBAR_HEIGHT, spr_9slice_navbar, 0, COL[colour.dark]);

var _btnCol;
_btnCol = (isHoveringOnX) ? COL[colour.highlight] : COL[colour.normal];
draw_sprite_ext(spr_navbar_button, 0, WINDOW[X], 0, 1, 1, 0, _btnCol, 1);

draw_set_font(fnt_title);
draw_set_valign(fa_middle);
draw_set_colour(COL[colour.normal]);
draw_text(10, 16, "Doujinshi Grabber v" + string_copy(GM_version, 1, string_length(GM_version)-2));

draw_set_halign(fa_right)
draw_set_colour((isHoveringOnX) ? COL[colour.normal] : COL[colour.dark]);
draw_text(WINDOW[X] - 16, 16, "X");
draw_set_colour(c_white);
draw_set_valign(fa_top);
draw_set_halign(fa_left)

