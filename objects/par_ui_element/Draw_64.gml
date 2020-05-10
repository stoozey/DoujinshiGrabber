var _scale, _pos;
_scale = [ image_xscale * scale, image_yscale * scale ];
_pos = [ x - ((_scale[X] - image_xscale) / 2), y - ((_scale[Y] - image_yscale) / 2) ];

draw_set_alpha(alphaAdjusted);

if (spriteNineSlice != spr_null)
	draw_9slice(_pos[X], _pos[Y], _scale[X], _scale[Y], spriteNineSlice, 0, COL[colour.normal]);

draw_set_font(fnt_textbox);
	draw_set_colour(COL[colour.text]);
		draw_text_box(_pos[X], _pos[Y], _scale[X], _scale[Y], text, true, scale, scale);
	draw_set_colour(c_white);
draw_set_alpha(1);