if (con_books.state != VIEW_STATE.BOOK_PAGES) exit;
if (backWidth < 12) exit;
if (backHeight < 12) exit;

var _x, _y;
_x		= (WINDOW[X] / 2) - (backWidth / 2);
_y		= ((WINDOW[Y] - VIEW_Y) / 2)  - (backHeight / 2) + VIEW_Y;

draw_9slice(_x-16, _y-16, max(backWidth, 12)+16, max(backHeight, 12)+16, spr_9slice_button, 0, COL[colour.dark]);

if (totalPages <= 0) exit;
if (con_books.bookSelected = noone) exit;
if (con_books.bookListSurfX != -WINDOW[X]) exit;

var _spr;
_spr = pages[pageIndex];

draw_sprite_ext(_spr, 0, _x, _y, scale, scale, 0, c_white, alpha);