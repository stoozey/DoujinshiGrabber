var _scale, _pos;
_scale = [ image_xscale * scale, image_yscale * scale ];
_pos = [ x - ((_scale[X] - image_xscale) / 2), y - ((_scale[Y] - image_yscale) / 2) ];

draw_set_alpha(alphaAdjusted);
draw_9slice(_pos[X], _pos[Y], _scale[X], _scale[Y], spriteNineSlice, 0, COL[colour.normal]);
draw_set_alpha(1);

var _spritePos, _spriteScale;
_spritePos		= [ _pos[X] + ((image_xscale / 2) * scale), _pos[Y] + ((image_yscale / 2) * scale) ];
_spriteScale	= [ scale/* - 0.2*/, scale/* - 0.2*/ ];

if (isColours)
{
	for (var i = 0; i < sprite_get_number(uiSprite); ++i)
	{
	    draw_sprite_ext(uiSprite, i + 1, _spritePos[X], _spritePos[Y], _spriteScale[X], _spriteScale[Y], 0, COL[i], 1);
	}
}

draw_sprite_ext(uiSprite, 0, _spritePos[X], _spritePos[Y], _spriteScale[X], _spriteScale[Y], 0, COL[colour.highlight], 1);