draw_9slice(0, 0, WINDOW[X], NAVBAR_HEIGHT, spr_9slice_navbar, 0, COL[colour.dark]);

draw_set_font(fnt_title);
draw_set_valign(fa_middle);
draw_set_colour(COL[colour.normal]);
draw_text(10, 16, "Doujinshi Grabber v" + string(GM_version));
draw_set_colour(c_white);
draw_set_valign(fa_top);

var _btnCol;
_btnCol = (isHoveringOnX) ? COL[colour.highlight] : COL[colour.normal];
draw_sprite_ext(spr_navbar_button, 0, WINDOW[X], 0, 1, 1, 0, _btnCol, 1);