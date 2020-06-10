var _surfExists;
_surfExists	= [  (surface_exists(surfBookList)),  (surface_exists(surfBookPages)) ];

if (state == VIEW_STATE.NULL)
{
	if (surface_exists(surfBookList))
			surface_free(surfBookList);	
	exit;
}

if (bookListSurfX == -WINDOW[X]) exit;

#region	create/destroy surfaces

if (!surface_exists(surfBookList))
	surfBookList = surface_create( WINDOW[X], WINDOW[Y] - VIEW_Y);

#endregion

var _switchingPage, _stateActive;
_switchingPage = false;
_stateActive = (state == VIEW_STATE.BOOK_LIST);

surface_set_target(surfBookList);

//	fill bg with colour
draw_sprite_ext(spr_pixel, 0, 0, 0, WINDOW[X], WINDOW[Y], 0, COL[colour.darkest], 1);

if (global.waiting) || (TweenExists(bookListSurfXTween)) || (TweenExists(shaderRadiusTween))
{
	shader_set(shd_blur_gaussian)
	shader_set_uniform_f(uData, WINDOW[X]/2,WINDOW[Y]/2, shaderRadius)//width,height,radius
}

var _distanceBetweenEdge;
_distanceBetweenEdge = 0;

if (listHasDeterminedPositions)
{
	
	#region footer variables
			
			var _footerW, _footerH, _footerX, _footerY;
			_footerW	=156;
			_footerH	= 48;
			_footerX	= (WINDOW[X] / 2) - (_footerW / 2);
			_footerY	= WINDOW[Y] - VIEW_Y - _footerH;
			
			var _isHoveringOnFooter, _footerBtnW, _footerHoveringBack, _footerHoveringNext;
			_isHoveringOnFooter	= (mouse_y_gui >= WINDOW[Y] - _footerH) && ((mouse_x_gui >= _footerX) && (mouse_x_gui <= _footerX + _footerW));
			draw_set_font(fnt_textbox);
			_footerBtnW					= string_width("<<");
			_footerHoveringBack	= (_isHoveringOnFooter) && (mouse_x_gui <= _footerX + _footerBtnW);
			_footerHoveringNext	= (_isHoveringOnFooter) && (mouse_x_gui >= _footerX + _footerW - _footerBtnW);

			#endregion
	
	#region draw main book list
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
				_y			= book_get_y(i) - bookListScroll;
				_scale	= book_get_scale(i);

				_newSize = [ (_size[X] * _scale), (_size[Y] * _scale) ];
			
				//	intereacting with books
				var _realY, _rect;
				_realY	= _y + VIEW_Y;
				_rect		= [ _x, _realY, _x + _newSize[X], _realY + _newSize[Y] ];
				if (_stateActive)
				{
					if (!_isHoveringOnFooter) &&  (mouse_y_gui > VIEW_Y) &&(collision_rectangle(_rect[0], _rect[1], _rect[2], _rect[3], cursor, false, true))
					{
						book_scale_up(_thisBook);
					
						if (!global.waiting)
							window_set_cursor(cr_handpoint);
					
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
							shaderRadiusTween = TweenFire(id, EaseOutSine, 0, 1, 0, 0.65, "shaderRadius", 0, 12);
							global.waiting = true;
						}
					}	
					else
					{
						book_scale_down(_thisBook);
					}
				}
			
				var _scaleSelected;
				_scaleSelected = _thisBook.scale;
			
				_scale *= _scaleSelected;
			
				draw_sprite_ext(_cover, 0, _x, _y, _scale, _scale, 0, c_white, 1);
			
				var _textOffset, _tX, _tY;
				_textOffset	= 4;
				_tX					= _x - 8;
				_tY					= ((_y + _newSize[Y]) * _scaleSelected) + _textOffset;
				draw_text_wrapped(_title, _tX, _tY, _newSize[X] * _scaleSelected, 1, bookTitleX);
			}
			#endregion
	
	#region footer interaction
		if (!global.waiting)
		{
			draw_9slice(_footerX, _footerY, _footerW, _footerH + 16, spr_9slice_button, 0, COL[colour.dark]);
			
			var _buff, _canGoBack, _canGoNext, _footerTY;
			_buff	= 10;
			_canGoBack = (global.pageNum > 1);
			_canGoNext = (global.pageNum < global.pageMax)
			_footerTY = _footerY + (_footerH / 2);
			
			#region draw footer text
			draw_set_font(fnt_textbox);
			draw_set_colour(COL[colour.text]);
			draw_set_alpha(0.8);
			draw_set_valign(fa_middle);
			
			if (!_canGoBack)
				draw_set_alpha(0.5);
			else
			{
				if (_footerHoveringBack)
					draw_set_alpha(1);
				footerBackNextScale[0] = Ease(footerBackNextScale[0], 1 + (_footerHoveringBack / 7), 0.4, EaseInOutSine);
			}
			draw_text_transformed(_footerX + _buff, _footerTY, "<", footerBackNextScale[0], footerBackNextScale[0], 0);
			draw_set_alpha(0.8);
			
			draw_set_halign(fa_center);
				draw_text(_footerX + (_footerW / 2), _footerTY, string(global.pageNum));
			
			if (!_canGoNext)
				draw_set_alpha(0.5);
			else
			{
				 if (_footerHoveringNext)
					draw_set_alpha(1);
				footerBackNextScale[1] = Ease(footerBackNextScale[1], 1 + (_footerHoveringNext / 7), 0.4, EaseInOutSine);
			}
			draw_set_halign(fa_right);
				draw_text_transformed(_footerX + _footerW - _buff, _footerTY, ">", footerBackNextScale[1], footerBackNextScale[1], 0);
			
			draw_set_alpha(1);
			draw_set_colour(c_white);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			#endregion
			
			if (_stateActive) && (_isHoveringOnFooter) && (mouse_check_button_pressed(mb_left))
			{
				if (_footerHoveringBack) && (_canGoBack)
				{
					global.pageNum = max(global.pageNum - 1, 1);
					_switchingPage = true;
				}
				else if (_footerHoveringNext) && (_canGoNext)
				{
					global.pageNum = min(global.pageNum + 1, global.pageMax);
					_switchingPage = true;
				}
			}
		}
			#endregion
	
	#region scrollbar
	var _surf, _surfW, _surfH,_barW, _barH, _barX, _barY, _isHoveringOnBar;
	_surf		= surfBookList;
	_surfW	= surface_get_width(_surf);
	_surfH	= surface_get_height(_surf);
	_barW	= 18 * scrollbarScale;
	_barH	= min(48, bookPageHeight - _surfH);
	_barX		= _surfW - _barW;
	_barY		= percent_amount(bookListScroll, bookPageHeight,_surfH - _barH, false);
	
	_isHoveringOnBar = (mouse_x_gui >= _barX - _barW) && (mouse_y_gui >= VIEW_Y)// && (mouse_y_gui <= _barY + _barH + VIEW_Y));
	
	scrollbarScale = Ease(scrollbarScale, ((_isHoveringOnBar) ? 1.5 : 1), 0.4, EaseInOutSine);
	
	if (_isHoveringOnBar) && (!global.waiting)
	{
		if (mouse_check_button(mb_left))
		{
			//var _mx;
			//_mx = mouse_y_gui - VIEW_Y - _barY;
			bookListScrollReal = clamp(percent_amount(mouse_y_gui - VIEW_Y, _surfH, bookPageHeight, false), 0,  bookPageHeight);
		}
	}
	
	draw_9slice(_barX, 0, _barW, _surfH, spr_9slice_scrollbar, 0, COL[colour.dark]);
	draw_9slice(_barX, _barY, _barW, _barH, spr_9slice_scrollbar, 0,  ((_isHoveringOnBar) ? COL[colour.highlight] : COL[colour.normal]));
	#endregion
}

if (shader_current() != -1)
	shader_reset();

surface_reset_target();

draw_surface(surfBookList, bookListSurfX, VIEW_Y);

if (_switchingPage)
	btn_search_api(true);

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
				for (var i = 0; i < totalPages; ++i) 
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
	
	_text = string(_percent) + "%";
	
	var _xx, _yy;
	_xx	= WINDOW[X] / 2;
	_yy	= WINDOW[Y] / 2;
	draw_set_font(fnt_textbox);
	var _w, _h;
	_w	= 156;
	_h	= string_height(_text) + 156;
	draw_9slice(_xx - (_w / 2), _yy - (_h / 2), _w, _h, spr_9slice_button, 0, COL[colour.dark], 1, 0.6);
	
	var _loadingBuff;
	_loadingBuff = 74;
	
	draw_loading_icon(_xx - 64, _yy - _loadingBuff);
	
	draw_set_colour(COL[colour.text]);
		draw_set_align(fa_center, fa_middle);
			draw_text(_xx, _yy + _loadingBuff, _text);
		draw_set_align(fa_left, fa_top);
	draw_set_colour(c_white);

	
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
			_y	+= _lastSizeY + _offset[Y];
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
	var _footerBuffer;
	_footerBuffer =  48;
	bookPageHeight = max(_y - _lastSizeY - (VIEW_Y * 0.6) + _footerBuffer, 0);
	listHasDeterminedPositions = true;
}
#endregion
