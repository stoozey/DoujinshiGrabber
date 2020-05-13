if (con_books.state != VIEW_STATE.BOOK_PAGES) exit;
if (backWidth < 12) exit;
if (backHeight < 12) exit;

var _menuIsTweening;
_menuIsTweening = (con_books.bookListSurfX != -WINDOW[X]);

if (_menuIsTweening) exit;

var _x, _y;
_x		= ((WINDOW[X] / 2) - (backWidth / 2));
_y		= ((WINDOW[Y] - VIEW_Y) / 2)  - (backHeight / 2) + VIEW_Y;


draw_set_align(fa_middle, fa_bottom);
draw_set_font(fnt_title);
draw_set_colour(COL[colour.text]);
draw_text((WINDOW[X] / 2), _y - 32, "Page " + string(pageIndexReal + 1) + "/" + string(totalPages));
draw_set_colour(c_white);
draw_set_align(fa_left, fa_top);

draw_9slice(_x-16, _y-16, max(backWidth, 12) + 32, max(backHeight, 12) + 32, spr_9slice_button, 0, COL[colour.dark]);

if (totalPages <= 0) exit;
if (con_books.bookSelected = noone) exit;

var _spr;
_spr = pages[pageIndex];

draw_sprite_ext(_spr, 0, _x, _y, scale, scale, 0, c_white, alpha);