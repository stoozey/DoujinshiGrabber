var _scale, _pos;
_scale = [ image_xscale * scale, image_yscale * scale ];
_pos = [ x - ((_scale[X] - image_xscale) / 2), y - ((_scale[Y] - image_yscale) / 2) ];

draw_sprite_ext(spr_9slice_button, 0, _pos[X], _pos[Y], _scale[X], _scale[Y], 0, COL[colour.normal], alphaAdjusted);

var _spritePos, _spriteScale;
_spritePos = [ _pos[X] + ((sprite_width / 2) * _scale[X]), _pos[Y] + ((sprite_height / 2) * _scale[Y]) ];
_spriteScale = [ _scale[X] - 0.2, _scale[Y] - 0.2 ];

if (isColours)
{
	for (var i = 0; i < sprite_get_number(uiSprite); ++i)
	{
	    draw_sprite_ext(uiSprite, i + 1, _spritePos[X], _spritePos[Y], _spriteScale[X], _spriteScale[Y], 0, COL[i], 1);
	}
}

draw_sprite_ext(uiSprite, 0, _spritePos[X], _spritePos[Y], _spriteScale[X], _spriteScale[Y], 0, COL[colour.highlight], 1);