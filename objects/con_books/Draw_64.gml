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
	shader_set_uniform_f(uData, WINDOW[X]/2,WINDOW[Y]/2, shaderRadius)//width,height,radius
}

var _distanceBetweenEdge;
_distanceBetweenEdge = 0;

switch (state)
{
	case VIEW_STATE.BOOK_LIST:
	{
		if (listHasDeterminedPositions)
		{
			var _x, _y;
			_x			= 0;
			_y			= 0;
			_scale	= 0;
			draw_set_font(global.fontJpn);
			for (var i = 0; i < booksTotal; ++i)
			{
				var _thisBook, _cover, _title;
				_thisBook	= book_get_container(i);
				if (_thisBook == undefined) || (!instance_exists(_thisBook)) continue;
			
				_cover		= _thisBook.cover;
				_title			= _thisBook.title;
				if (_cover == -1) || (!sprite_exists(_cover)) continue;
			
				var _size,_newSize;
				_size		= [ sprite_get_width(_cover), sprite_get_height(_cover) ];
				_x			= book_get_x(i);
				_y			= book_get_y(i);
				_scale	= book_get_scale(i);

				_newSize = [ (_size[X] * _scale), (_size[Y] * _scale) ];
			
				//	intereacting with books
				var _realY, _rect;
				_realY	= _y + VIEW_Y - bookListScroll;
				_rect		= [ _x, _realY, _x + _newSize[X], _realY + _newSize[Y] ];
				if (collision_rectangle(_rect[0], _rect[1], _rect[2], _rect[3], cursor, false, true))
				{
					book_scale_up(_thisBook);
					if (mouse_check_button_pressed(mb_left)) && (bookSelected == noone)
					{
						//	fade out to next state: viewing book
						with (obj_container_book)
						{
							if (id != _thisBook)
								book_scale_down(id)
							else
								event_user(1);
						}
						bookSelected = _thisBook;
						TweenFire(id, EaseOutSine, 0, 1, 0, 0.65, "shaderRadius", 0, 12);
						global.waiting = true;
					}
				}	
				else
				{
					book_scale_down(_thisBook);
				}
			
				var _scaleSelected;
				_scaleSelected = _thisBook.scale;
			
				_scale *= _scaleSelected;
			
				draw_sprite_ext(_cover, 0, _x, _y - bookListScroll, _scale, _scale, 0, c_white, 1);
			
				var _textOffset, _tX, _tY;
				_textOffset	= 4;
				_tX					= _x - 8;
				_tY					= ((_y + _newSize[Y] - bookListScroll) * _scaleSelected) + _textOffset;
				draw_text_wrapped(_title, _tX, _tY, _newSize[X] * _scaleSelected, 1, bookTitleX);
			}
			//bookPageHeight = max(_y - _lastSizeY, 0);
		}
	}break;
	
	case VIEW_STATE.BOOK_PAGES:
	{
		
	}break;
}

if (shader_current() != -1)
	shader_reset();

surface_reset_target();

draw_surface(surfBookList, 0, VIEW_Y);
// loading text
if (global.waiting)
{
	var _loadTotal = 0, _loadAmount = 0, _percent, _text;
	if (state == VIEW_STATE.BOOK_LIST)
	{
		if (bookSelected == noone)
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
		else
		{
			with (bookSelected)
			{
				var _totalPages;
				_totalPages = array_length_1d(pageUrls);
				for (var i = 0; i < _totalPages; ++i) 
				{
					var _i, _tot, _cur;
					_i			= (i + 1);
					_tot	= dataDownloadTotal[_i];
					_cur	= dataDownloadCurrent[_i];
			
					if (_tot == undefined) || (_cur == undefined) continue;
			
					_loadTotal		+= _tot;
					_loadAmount	+= _cur;
				}
			}
		}
	}
	
	switch ((_loadTotal == 0) && (_loadAmount == 0) )
	{
		case false: _percent = floor(percent_amount(_loadAmount, _loadTotal, 100, false)); break;
		case true: _percent = 0; break;
	}
	
	_text = "Loading...\n" + string(_percent) + "%";
	
	var _xx, _yy;
	_xx	= WINDOW[X] / 2;
	_yy	= WINDOW[Y] / 2;
	draw_set_font(fnt_textbox);
	var _w, _h;
	_w	= string_width(_text) + 32;
	_h	= string_height(_text) + 32;
	draw_set_alpha(0.4);
	draw_9slice(_xx - (_w / 2), _yy - (_h / 2), _w, _h, spr_9slice_button, 0, COL[colour.dark]);
	draw_set_alpha(1);
	
	draw_set_colour(COL[colour.text]);
	draw_set_align(fa_center, fa_middle);
	draw_text(_xx, _yy, _text);
	draw_set_colour(c_white);
	draw_set_align(fa_left, fa_top);
	

	
	alarm[0]		= room_speed * 2;
	bookTitleX	= 0;
}
#region set list menu positions
else if (state == VIEW_STATE.BOOK_LIST) && (!listHasDeterminedPositions)
{
	var _offset, _x, _y, _lastSizeY, _pagesInRow;
	_offset = [ 64, 92 ];	//	the x and y offset between eat book cover
	_x = _offset[X];
	_y = 0;
	_lastSizeY = 0;
	_pagesInRow = 0;
	//draw_set_align(fa_center, fa_top);
	draw_set_font(global.fontJpn);
	for (var i = 0; i < booksTotal; ++i)
	{
		_pagesInRow++;
		var _thisBook, _cover, _title;
		_thisBook	= book_get_container(i);
		if (_thisBook == undefined) || (!instance_exists(_thisBook)) continue;
		
		_cover		= _thisBook.cover;
		_title			= _thisBook.title;
		if (_cover == -1) || (!sprite_exists(_cover)) continue;
		
		var _size, _scale, _newSize;
		_size		= [ sprite_get_width(_cover), sprite_get_height(_cover) ];
		_scale	= 1;

		while ((_size[Y] * _scale) > COVER_H)
			_scale -= 0.01;
		
			
		_newSize = [ (_size[X] * _scale), (_size[Y] * _scale) ];
		
		if (_x + _newSize[X] >= WINDOW[X])
		{
			var _thisDistance;
			_thisDistance = WINDOW[X] - _x;
			_distanceBetweenEdge = min(_thisDistance, _distanceBetweenEdge);
			
			//	center the covers
			for (var p = 0; p < _pagesInRow; ++p)
			{
			    var _book;
				_book = BOOK_LIST[| i - p];
				_book[@ BOOK_IND.XX] += (_thisDistance / 2);
				//BOOK_LIST[| p] = _book;
			}
			
			_x	= _offset[X];
			_y	+= _newSize[Y] + _offset[Y];
			_lastSizeY = 0;
			_pagesInRow = 1;
		}
		_lastSizeY = max(_lastSizeY, _newSize[Y]);
		
		BOOK_LIST[| i] = [ _thisBook, _x, _y, _scale ];
		
		_x	+=_newSize[X] + _offset[X];
		
		//	center the covers that didn't form a full row
		if (i == booksTotal - 1) && (_pagesInRow > 0)
		{
			var _thisDistance;
			_thisDistance = WINDOW[X] - _x;
			for (var p = 0; p < _pagesInRow; ++p)
			{
			    var _book;
				_book = BOOK_LIST[| i - p];
				_book[@ BOOK_IND.XX] += (_thisDistance / 2);
				//BOOK_LIST[| p] = _book;
			}
		}
	}
	bookPageHeight = max(_y - _lastSizeY, 0);
	listHasDeterminedPositions = true;
}
#endregion