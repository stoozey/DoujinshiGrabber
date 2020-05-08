///@arg string
///@arg x
///@arg y
///@arg width
///@arg scale
///@arg time

var _string, _x, _y, _maxWidth, _scale, _time;
_string			= argument0;
_x					= argument1;
_y					= argument2;
_maxWidth	= argument3;
_scale			= argument4;
_time				= argument5;

_maxWidth *= _scale;

var _buff, _surf, _width, _wrap, _timeAdjusted, _tX;
_buff						= (16*_scale);
_surf						= surface_create(_maxWidth + _buff, string_height(_string) * _scale);
_width					= (string_width(_string) * _scale);
_wrap					= (_width  > _maxWidth);
_timeAdjusted	= _time * (_width + string_width(" "));
_tX							= (_wrap) ? -_timeAdjusted : 0;


//_tX += _buff;

surface_set_target(_surf);
	draw_clear_alpha(c_white, 0);
	
	draw_text_transformed(_tX  , 0, _string, _scale, _scale, 0);
	
	if (_wrap)
	{
		draw_text_transformed(_tX + _width , 0, " " + _string, _scale, _scale, 0);
	}
	
surface_reset_target();

draw_surface(_surf, _x, _y);

surface_free(_surf);