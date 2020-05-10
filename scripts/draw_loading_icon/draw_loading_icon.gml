///@arg x
///@arg y
var _x, _y;
_x	= argument0;
_y	= argument1;

var _dlSurf;
_dlSurf = surface_create(128, 128);

surface_set_target(_dlSurf);
	draw_clear_alpha(c_white, 0);
	draw_sprite_ext(spr_downloading, 1, 0, 10 + (128 * downloadAnim), 1, 1, 0, COL[colour.text], 1);
surface_reset_target();

draw_sprite_ext(spr_downloading, 0, _x, _y, 1, 1, 0, COL[colour.text], 1);
draw_surface(_dlSurf, _x, _y);

surface_free(_dlSurf);
_dlSurf = undefined;