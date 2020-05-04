///@arg x
///@arg y
///@arg width
///@arg height
///@arg string
///@arg [centered]
///@arg [x_scale]
///@arg [y_scale]

var _x, _y, _width, _height, _text, _centred, _scaleX, _scaleY;
_x					= argument[0];
_y					= argument[1];
_width			= argument[2];
_height			= argument[3];
_text				= argument[4];
_centred		= (argument_count > 5) ? argument[5] : false;
_scaleX			= (argument_count > 6) ? argument[6] : 1;
_scaleY			= (argument_count > 7) ? argument[7] : 1;

var  _txtScale;
_txtScale = [1, 1];

while ((string_height(text) * _txtScale[Y]) > _height)
{
	_txtScale[Y] -= 0.001;
	_txtScale[X] -= 0.001;
}

while ((string_width(_text) * _txtScale[X]) > (_width))
	_txtScale[X] -= 0.001;

var _align;
_align = [ draw_get_halign(), draw_get_valign() ];
if (_centred)
{
	_x += (_width / 2);
	_y += (_height / 2);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
}

draw_text_transformed(_x, _y, _text, _scaleX * _txtScale[X], _scaleY * _txtScale[Y], 0);

if (_centred)
{
	draw_set_halign(_align[X]);
	draw_set_valign(_align[Y]);
}