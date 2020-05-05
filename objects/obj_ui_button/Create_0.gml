// Inherit the parent event
event_inherited();

isGoButton = (btnScript == btn_search_api);
if (isGoButton)
{
	var _par;
	with (obj_ui_textbox)
	{
		if (isTags) _par = id;
	}
	anchorOwner = _par;
}