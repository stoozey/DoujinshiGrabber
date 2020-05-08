var _surfExists;
_surfExists	= [  (surface_exists(surfBookList)),  (surface_exists(surfBookPages)) ];

if (state == VIEW_STATE.NULL)
{
	if (_surfExists[VIEW_STATE.BOOK_PAGES])
			surface_free(surfBookPages);	
	if (_surfExists[VIEW_STATE.BOOK_LIST])
			surface_free(surfBookList);	
	exit;
}

#region	create/destroy surfaces
switch (state)
{
	case VIEW_STATE.BOOK_LIST:
	{
		if (!_surfExists[VIEW_STATE.BOOK_LIST])
			surfBookList = surface_create( WINDOW[X], WINDOW[Y] - VIEW_Y);
		if (_surfExists[VIEW_STATE.BOOK_PAGES])
			surface_free(surfBookPages);	
	}break;
	
	case VIEW_STATE.BOOK_PAGES:
	{
		if (!_surfExists[VIEW_STATE.BOOK_PAGES])
			surfBookPages = surface_create( WINDOW[X], WINDOW[Y] - VIEW_Y);
		if (_surfExists[VIEW_STATE.BOOK_LIST])
			surface_free(surfBookList);	
	}break;
}
#endregion

var _surfs;
_surfs = [ surfBookList, surfBookPages ];

surface_set_target(_surfs[state]);

draw_clear_alpha(c_white, 0);

if (global.waiting)
{
	shader_set(shd_blur_gaussian)
	shader_set_uniform_f(uData, WINDOW[X],WINDOW[Y], 12)//width,height,radius
}

var _distanceBetweenEdge;
_distanceBetweenEdge = 0;

switch (state)
{
	case VIEW_STATE.BOOK_LIST:
	{
		var _offset;
		_offset = [ 64, 92 ];	//	the x and y offset between eat book cover
		
		var _x, _y;
		_x = _offset[X];
		_y = 0;
		//draw_set_align(fa_center, fa_top);
		draw_set_font(global.fontJpn);
		for (var i = 0; i < booksTotal; ++i)
		{
			var _thisBook, _cover, _title;
			_thisBook	= BOOK_LIST[| i];
			if (_thisBook == undefined) continue;
			
			_cover		= _thisBook.cover;
			_title			= _thisBook.title;
			if (_cover == -1) || (!sprite_exists(_cover)) break;
			
			var _size, _scale, _newSize;
			_size = [ sprite_get_width(_cover), sprite_get_height(_cover) ];
			_scale = 1;
			
			while ((_size[Y] * _scale) > COVER_H)
				_scale -= 0.01;
				
			_newSize = [ (_size[X] * _scale), (_size[Y] * _scale) ];
			
			if (_x + _newSize[X] >= WINDOW[X])
			{
				_distanceBetweenEdge = min(WINDOW[X] - _x, _distanceBetweenEdge);
				
				_x	= _offset[X];
				_y	+= _newSize[Y] + _offset[Y];
			}
			
			draw_sprite_ext(_cover, 0, _x, _y - bookListScroll, _scale, _scale, 0, c_white, 1);
			
			//var _textSize, _textScale;
			//_textSize		= string_width(_title);
			//_textScale	= 1;
			//while ((_textSize * _textScale) > (_newSize[X] + _offset[X]))
			//	_textScale -= 0.01;
			
			//draw_text_transformed(_x + (_newSize[X] / 2), _y + _newSize[Y] + 4 - bookListScroll, _title, _textScale, _textScale, 0);
			
			draw_text_wrapped(_title, _x - 8 /*+ (_newSize[X] / 2)*/, _y + _newSize[Y] + 4 - bookListScroll, _newSize[X], 1, bookTitleX);
			
			_x	+=_newSize[X] + _offset[X];
		}
		//draw_set_align(fa_left, fa_top);
	}break;
	
	case VIEW_STATE.BOOK_PAGES:
	{
		
	}break;
}

if (shader_current() != -1)
	shader_reset();

surface_reset_target();

draw_surface(surfBookList, (_distanceBetweenEdge / 2), VIEW_Y);

#region loading text
if (global.waiting)
{
	var _loadTotal = 0, _loadAmount = 0, _percent, _text;
	if (state == VIEW_STATE.BOOK_LIST)
	{
		with (obj_container_book)
		{
			var _tot, _cur;
			_tot = dataDownloadTotal[0];
			_cur = dataDownloadCurrent[0];
			
			if (_tot == undefined) || (_cur == undefined) continue;
			
			_loadTotal		+= _tot;
			_loadAmount	+= _cur;
		}
	}
	
	switch ((_loadTotal == 0) && (_loadAmount == 0) )
	{
		case false: _percent = floor(percent_amount(_loadAmount, _loadTotal, 100, false)); break;
		case true: _percent = 0; break;
	}
	
	_text = "Loading...\n" + string(_percent) + "%";
	
	draw_set_font(fnt_textbox);
	draw_set_align(fa_center, fa_middle);
	draw_text(WINDOW[X] / 2, WINDOW[Y] / 2, _text);
	draw_set_align(fa_left, fa_top);
	
	alarm[0] = room_speed * 2;
}
#endregion