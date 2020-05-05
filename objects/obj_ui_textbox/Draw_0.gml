
//if (!isTags) exit;

//var _buff, _y;
//_buff = 8;
//_y = y + _buff;

//var _starX, _dropdownX, _col, _textIsFav;
//_starX = x + image_xscale - 32 - (_buff*2);
//_dropdownX = x + image_xscale - _buff;
//_col = global.navbarCol;
//_textIsFav = (ds_list_find_index(favourites, text) != -1);

//if (!global.loading) && (is_inbetween(mouse_x, _starX - 32, x + image_xscale)) && (is_inbetween(mouse_y, _y, _y + 48)) 
//{
//	window_set_cursor(cr_handpoint);
	
//	if (mouse_check_button_pressed(mb_left))
//	{
//		#region opening / closing favourites dropdown
//		if (ds_list_size(favourites) > 0) && (is_inbetween(mouse_x, _dropdownX, _dropdownX - 32)) 
//		{
//			obj_favourites.active = !obj_favourites.active;
			
//			if (TweenExists(arrowTween))
//				TweenDestroy(arrowTween);
			
//			with (obj_favourites)
//			{
//				if (TweenExists(surfTween))
//					TweenDestroy(surfTween);
//			}
			
//			#macro _EASE_ARROW (EaseOutCubic)
//			var _surfY;
//			_surfY = _FAVOURITES_MAX_H//min( (52 * ds_list_size(favourites)), _FAVOURITES_MAX_H);
//			switch (obj_favourites.active)
//			{
//				case true:
//				{
//					arrowTween = TweenFire(id, _EASE_ARROW, 0, true, 0, 0.25, "arrowDir", 0, -90);
					
//					with (obj_favourites)
//					{
//						enabled = true;
//						scroll = 0;
//						scrollReal = 0;
//						surfTween = TweenFire(id, _EASE_ARROW, 0, true, 0, 0.5,
//							"surfY", -_surfY, 0
//						);
//					}
//				}break;
				
//				case false:
//				{
//					arrowTween = TweenFire(id, _EASE_ARROW, 0, true, 0, 0.25, "arrowDir", -90, 0);
					
//					with (obj_favourites)
//					{
//						surfTween = TweenFire(id, _EASE_ARROW, 0, true, 0, 0.5, "surfY", 0, -_surfY);
//						TweenAddCallbackUser(surfTween, TWEEN_EV_FINISH, id, 0);
//					}
//				}break;
//			}
//		}
//		#endregion
		
//		#region adding	/	removing from favourites
//		if (is_inbetween(mouse_x, _starX, _starX - 32)) && (text != "")
//		{
//			switch (_textIsFav)
//			{
//				//	add to favourites
//				case false:
//				{
//					ds_list_add(favourites, text);
		
//					if (TweenExists(starTween))
//						TweenDestroy(starTween);
				
//					starTween = TweenFire(id, EaseOutBack, 0, true, 0, 0.3, "starScale", 0, 1);
//				}break;
			
//				//	remove from favourites
//				case true:
//				{
//					var _thisPos;
//					_thisPos = ds_list_find_index(favourites, text);
//					if (_thisPos == -1) break;
				
//					ds_list_delete(favourites, _thisPos);
		
//					if (TweenExists(starTween))
//						TweenDestroy(starTween);
				
//					starTween = TweenFire(id, EaseOutBack, 0, true, 0, 0.3, "starScale", 1, 0);
//				}break;
//			}
			
//			with (obj_favourites)
//			{
//				surface_free(surf);
//				surf = 1;
//			}
			
//		}
//		#endregion
		
//	}
//}
//else if (starScale != 1) && (_textIsFav) && (!TweenExists(starTween))
//	starScale = 1;

//if (!_textIsFav) && (!TweenExists(starTween)) && (starScale > 0)
//	starScale = 0;

//draw_sprite_ext(spr_dropdown_arrow, 0, _dropdownX - 16, _y + 16, 1, 1, arrowDir, _col, 0.7);
//draw_sprite_ext(spr_star, 0, _starX, _y, 1, 1, 0, _col, 0.7);
//draw_sprite_ext(spr_star_alt, 0, _starX - 16, _y + 16, starScale, starScale, 0, global.highlightCol, 0.7);