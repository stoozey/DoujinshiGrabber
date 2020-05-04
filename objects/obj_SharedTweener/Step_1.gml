/// @description Process Tween Logic

// Mark update loop as being processed
inUpdateLoop = true;

//--------------------------
// Manage Delta Timing
//--------------------------
prevDeltaTime = deltaTime;      // Store previous usable delta time format
deltaTime = delta_time/1000000; // Update usable delta time format

// Let's prevent delta time from exhibiting sporadic behaviour, shall we?
// IF the delta time is greater than the set max duration
if (deltaTime > maxDelta)
{
    // IF delta time was already restored
    if (deltaRestored)
    { 
        deltaTime = maxDelta; // Set delta time to max delta value
    }
    else
    { 
        deltaTime = prevDeltaTime; // Restore delta time to value from previous step
        deltaRestored = true;      // Flag delta time as being restored
    }
}
else
{
    deltaRestored = false; // Clear restored flag
}

// Adjust for update interval difference
deltaTime += addDelta;

// Assign time scales to array for optimisation purposes
var _timeScale = timeScale;
var _timeScaleDelta = _timeScale*deltaTime;
timeScaleDelta = _timeScaleDelta;

//---------------------------------
// Process Main Update Loop
//---------------------------------

// Initiate local variables for iteration
var _tIndex, _tweens = tweens, _delayedTweens = delayedTweens;

// IF the system is active
if (isEnabled)
{     
    tick++; // Increment step tick
    
    // Make adjustment for delta time if update interval not achieved
    if (tick < updateInterval) { addDelta += deltaTime; }
    else                       { addDelta = 0.0; }
    
    // WHILE the system tick is greater than the set step update interval -- NEED TO UPDATE FOR DELTA TIMING
    while (tick >= updateInterval)
    {   
        tick -= updateInterval; // Decrement step tick by update interval value
        
        // IF system timescale isn't "paused"
        if (timeScale != 0)
        {   
            //--------------------------------------------------
            // Process Tweens
            //--------------------------------------------------
            _tIndex = -1; 
            repeat(tweensProcessNumber)
            {
                var _t = _tweens[| ++_tIndex]; // Get tween and increment index
                
                // Process tween if target/state exists/active
                if (instance_exists(_t[TWEEN.STATE]))
                {
                    if (_t[TWEEN.DELTA]) var _time = _t[TWEEN.TIME] + _t[TWEEN.TIME_SCALE] * _timeScaleDelta;   
                    else                 var _time = _t[TWEEN.TIME] + _t[TWEEN.TIME_SCALE] * _timeScale;
                    
                    var _duration = _t[TWEEN.DURATION]; // Cache duration
                    
                    // IF tween is within start/destination
                    if (_time > 0 && _time < _duration)
                    {
                        // Assign updated time
                        _t[@ TWEEN.TIME] = _time;
					
						if (TGMS_OPTIMISE_NULL_PROPERTY)
						{
							if (_t[TWEEN.PROPERTY] != TGMS_NULL__)
							{
								script_execute(_t[TWEEN.PROPERTY], script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
							}
						}
						else
						{
							script_execute(_t[TWEEN.PROPERTY], script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
						}
					}
                    else // Tween has reached start or destination
                    if (_t[TWEEN.TIME_SCALE] != 0) // Make sure time scale isn't "paused"
                    {
                        var _property = _t[TWEEN.PROPERTY]; // Cache property -- temporary?
                        
                        // Update tween based on its play mode -- Could put overflow wait time in here????
                        switch(_t[TWEEN.MODE])
                        {
                        case TWEEN_MODE_ONCE:
                            _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;  // Set tween's state as STOPPED
                            _t[@ TWEEN.TIME] = _duration*(_time > 0); // Update tween's time
                            
                            // Update property
                            script_execute(_property, _t[TWEEN.START] + _t[TWEEN.CHANGE]*(_time > 0), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
                            
                            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH); // Execute FINISH event
                            if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }          // Destroy tween if temporary
                        break;
                        
                        case TWEEN_MODE_BOUNCE:
                            if (_time > 0)
                            {
	                            _time = 2*_duration - _time;        // Update raw time with epsilon compensation
	                            _t[@ TWEEN.TIME] = _time;           // Assign raw time to tween
	                            _time = clamp(_time, 0, _duration); // Clamp raw time used for tween calculation
                                
	                            // Update property
	                            script_execute(_property, script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
                                
	                            _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];           // Reverse direction 
	                            _t[@ TWEEN.TIME_SCALE] = -_t[TWEEN.TIME_SCALE];         // Reverse time scale
	                            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE); // Execute CONTINUE event
                            }
                            else
                            {
                                _t[@ TWEEN.TIME] = 0; // Update tween's time
                                
                                // Update property
                                script_execute(_property, _t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
                                
                                _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;              // Set tween state as STOPPED
                                TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH); // Execute FINISH event
                                if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }          // Destroy tween if temporary
                            }
                        break;
                        
                        case TWEEN_MODE_PATROL:
	                        // Update raw time with epsilon compensation
	                        if (_time > 0) { _time = 2*_duration - _time; }
	                        else           { _time = -_time; }
                        
	                        _t[@ TWEEN.TIME] = _time;           // Assign raw time to tween
	                        _time = clamp(_time, 0, _duration); // Clamp raw time used for tween calculation
                            
	                        // Update property
	                        script_execute(_property, script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
                            
	                        _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];           // Reverse tween's direction
	                        _t[@ TWEEN.TIME_SCALE] = -_t[TWEEN.TIME_SCALE];         // Reverse tween's time scale
	                        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE); // Execute CONTINUE event
                        break;
                        
                        case TWEEN_MODE_LOOP:
                            // Update tween's time depending on side of loop
                            if (_time > 0) { _time = _time - _duration; }
                            else           { _time = _time + _duration; }
                            
                           _t[@ TWEEN.TIME] = _time;           // Assign raw time to tween
                           _time = clamp(_time, 0, _duration); // Clamp raw time used for tween calculation
                            
                            // Update property
                            script_execute(_property, script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
                            
                            // Execute LOOP event
                            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE);
                        break;
                        
                        case TWEEN_MODE_REPEAT:
                            // Update tween's time and starting location based on side of loop
                            if (_time > 0)
                            {
                                _time = _time - _duration; // Update raw time with epsilon compensation
                                _t[@ TWEEN.START] = _t[TWEEN.START] + _t[TWEEN.CHANGE]; // Update start
                            }
                            else
                            {
                                _time = _time + _duration; // Update raw time with epsilon compensation
                                _t[@ TWEEN.START] = _t[TWEEN.START] - _t[TWEEN.CHANGE]; // Update start
                            }
                            
                            _t[@ TWEEN.TIME] = _time;          // Assign raw time to tween
                           _time = clamp(_time, 0, _duration); // Clamp raw time used for tween calculation
                            
                            // Update property
                            script_execute(_property, script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
                            
                            // Execute LOOP event
                            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE);
                        break;
                        
                        default:
                            show_error("Invalid Tween Mode! --> Reverting to TWEEN_MODE_ONCE", false);
                            _t[@ TWEEN.MODE] = TWEEN_MODE_ONCE;
                        }
                    }
                }
            }
			
			//----------------------------------------
            // Process Delays
            //----------------------------------------
            _tIndex = -1;
            repeat(delaysProcessNumber)
            {
                var _t = _delayedTweens[| ++_tIndex]; // Get next tween from delayed tweens list
    
                // IF tween instance exists AND delay is NOT destroyed
                if (_t[TWEEN.STATE] == TWEEN_STATE.DELAYED && instance_exists(_t[TWEEN.TARGET]))
                { 
                    // Decrement delay timer
					if (_t[TWEEN.DELTA]) _t[@ TWEEN.DELAY] -= abs(_t[TWEEN.TIME_SCALE]) * _timeScaleDelta;
					else				 _t[@ TWEEN.DELAY] -= abs(_t[TWEEN.TIME_SCALE]) * _timeScale;
                    
                    // IF the delay timer has expired
                    if (_t[TWEEN.DELAY] <= 0)
                    {
                        ds_list_delete(_delayedTweens, _tIndex--);                  // Remove tween from delay list
                        _t[@ TWEEN.DELAY] = -1;										// Indicate that delay has been removed from delay list
                        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH_DELAY); // Execute FINISH DELAY event
                        _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];                       // Set tween as active    
                        // Update property with start value                 
                        script_execute(_t[TWEEN.PROPERTY], _t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
                        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PLAY); // Execute PLAY event callbacks
                    }
                }
                else // If delay is marked for removal or tween is destroyed
                if (_t[TWEEN.DELAY] == -1 || _t[TWEEN.STATE] == TWEEN_STATE.DESTROYED)
                {
                    ds_list_delete(_delayedTweens, _tIndex--); // Remove tween from delay list
                }
            }
        }
    }
}

//--------------------------------------------------
// Event Cleaner
//--------------------------------------------------
if (ds_priority_size(eventCleaner))
{
    var _event = ds_priority_delete_min(eventCleaner); // Get event to check for cleaning

    // Cycle through all callbacks, except the new one -- make sure not to check event status index event[0]
    var _cbIndex = ds_list_size(_event);
    repeat(_cbIndex-1)
    {
        var _cb = _event[| --_cbIndex];           // Get next callback and decrement iterator
        var _target = _cb[TWEEN_CALLBACK.TARGET]; // Cache callback's target instance
        
        // If the tween's target instance doesn't exist...
        if (instance_exists(_target) == false)
        {
            // Attempt to activate target instance
            instance_activate_object(_target);
            
            // If the target instance now exists...
            if (instance_exists(_target))
            {
                instance_deactivate_object(_target); // Put target instance back to deactivated state
            }
            else // Proceed to delete callback from event list
            {
                ds_list_delete(_event, _cbIndex);
            }
        }
    }
}

//--------------------------------------------------
// Passive Tween Cleaner
//--------------------------------------------------
// Check to see if system is being flushed
// Else clamp number of cleaning iterations
var _cleanIterations;
if (flushDestroyed)
{
    flushDestroyed = false;                   // Clear "flush" flag
    autoCleanIndex = ds_list_size(_tweens);   // Set starting clean index to list size
    _cleanIterations = ds_list_size(_tweens); // Set number of iterations to list size 
}
else
{
    _cleanIterations = min(autoCleanIterations, autoCleanIndex, ds_list_size(_tweens)); // CLAMP!
}

// Start the cleaning!
repeat(_cleanIterations)
{   
    // Cache tween
    var _t = _tweens[| --autoCleanIndex];
    
    // IF tween target does not exist...
    if (instance_exists(_t[TWEEN.TARGET]) == false)
    {
        // Attempt to activate target instance
        instance_activate_object(_t[TWEEN.TARGET]);
        
        // IF instance now exists, put it back to deactivated state
        if (instance_exists(_t[TWEEN.TARGET]))
        {
            instance_deactivate_object(_t[TWEEN.TARGET]);
        }
        else // Handle tween destruction...
        {
            ds_list_delete(_tweens, autoCleanIndex); // Remove tween from tweens list
            
            // Invalidate tween handle
            if (ds_map_exists(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]))
            {
                ds_map_delete(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]);
            }
        
            _t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set tween state as destroyed
            
            // Destroy tween events if events map exists
            if (_t[TWEEN.EVENTS] != -1)
            {
                var _events = _t[TWEEN.EVENTS];        // Cache events
                var _key = ds_map_find_first(_events); // Find key to first event
                
                // Cycle through and destroy all events
                repeat(ds_map_size(_events))
                {
                    ds_list_destroy(_events[? _key]);       // Destroy event list
                    _key = ds_map_find_next(_events, _key); // Find key for next event
                }
                
                ds_map_destroy(_events); // Destroy events map
            }
        }
    }
}

// Place auto clean index to size of tweens list if below or equal to 0
if (autoCleanIndex <= 0) { autoCleanIndex = ds_list_size(_tweens); }

// Indicate that we are finished processing the main update loop
inUpdateLoop = false;

// I forget why this is here... must be a reason!!
if (doDestroy)
{
	event_perform(ev_destroy,0);
}
