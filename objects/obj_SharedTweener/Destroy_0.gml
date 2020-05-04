/// @description System Cleanup

if (firstDestroy)
{
    firstDestroy = false;
    
    //-------------------------------------------------
    // Destroy Tweens and Delays for Persistent Rooms
    //-------------------------------------------------
    TGMS_ClearRoom(all);
    
    //-----------------------------------------
    // Remove self as shared tweener singleton
    //-----------------------------------------
    global.TGMS_SharedTweener = noone;
    
    //---------------------------------------
    // Clear id reference map
    //---------------------------------------
    ds_map_clear(global.TGMS_MAP_TWEEN);
}

if (inUpdateLoop)
{
    doDestroy = true;
    return 0;
}

// Return early if Destroy Event already called
// Else mark tweener as being destroyed
if (isDestroyed) { return 0; }
else             { isDestroyed = true; }

//---------------------------------------------
// Destroy remaining tweens
//---------------------------------------------
var _tweens = tweens;
var _tIndex = -1;
repeat(ds_list_size(_tweens))
{   
    var _t = _tweens[| ++_tIndex];             // Get tween and increment iterator
    _t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set state as destroyed
    _t[@ TWEEN.ID] = undefined;                // Nullify self reference
    
    // Destroy tween events if events map exists
    if (_t[TWEEN.EVENTS] != -1)
    {
        var _events = _t[TWEEN.EVENTS]; // Cache events
        
        // Iterate through events
        repeat(ds_map_size(_events))
        {
            ds_list_destroy(_events[? ds_map_find_first(_events)]); // Destroy event list
            ds_map_delete(_events, ds_map_find_first(_events));     // Delete event key   
        }
        
        // Destroy events map and invalidate tween's reference
        ds_map_destroy(_events);
        _t[@ TWEEN.EVENTS] = -1; // :: Do I need this?
    }
}

//---------------------------------------
// Destroy Data Structures
//---------------------------------------
ds_list_destroy(tweens);
ds_list_destroy(delayedTweens);
ds_map_destroy(simpleTweens);
ds_map_destroy(pRoomTweens);
ds_map_destroy(pRoomDelays);
ds_priority_destroy(eventCleaner);
