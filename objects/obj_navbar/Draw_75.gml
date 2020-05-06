draw_9slice(0, 0, WINDOW[X], NAVBAR_HEIGHT, spr_9slice_navbar, 0, COL[colour.dark]);

var _btnCol;
_btnCol = (isHoveringOnX) ? COL[colour.highlight] : COL[colour.normal];
draw_sprite_ext(spr_navbar_button, 0, WINDOW[X], 0, 1, 1, 0, _btnCol, 1);