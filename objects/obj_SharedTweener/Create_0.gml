/// @description Initialization v1.0.3
/*
	Proverbs 3:5-8
	Trust in the Lord with all your heart and lean not on your own understanding;
	in all your ways submit to him, and he will make your paths straight.
	Do not be wise in your own eyes; fear the Lord and shun evil.
	This will bring health to your body and nourishment to your bones.
*/

// Global system-wide settings
isEnabled = global.TGMS_IsEnabled;                     // System's active state flag
timeScale = global.TGMS_TimeScale;                     // Global time scale of tweening engine
timeScaleDelta = timeScale * delta_time/1000000;	   // Global time scale effected by delta timing
minDeltaFPS = global.TGMS_MinDeltaFPS;                 // Minimum frame rate before delta time will lag behind
updateInterval = global.TGMS_UpdateInterval;           // Step interval to update system (default = 1)
autoCleanIterations = global.TGMS_AutoCleanIterations; // Number of tweens to check each step for auto-cleaning

// System maintenance variables
tick = 0;                            // System update timer
autoCleanIndex = 0;                  // Used to track index when processing passive memory manager
keepPersistent = false;              // Becomes true if tweening used in persistent room
maxDelta = 1/minDeltaFPS;            // Cache delta cap
deltaTime = delta_time/1000000;      // Let's make delta time more practical to work with, shall we?
prevDeltaTime = deltaTime;           // Holds delta time from previous step
deltaRestored = false;               // Used to help maintain predictable delta timing
addDelta = 0.0;                      // Amount to add to delta time if update interval not reached
flushDestroyed = false;              // Flag to indicate if destroyed tweens should be immediately cleared
isDestroyed = false;                 // Flag to ensure Destroy/Room_End events only called when appropriate
tweensProcessNumber = 0;             // Number of tweens to be actively processed in update loop
delaysProcessNumber = 0;             // Number of delays to be actively processed in update loop
inUpdateLoop = false;                // Is tweening system actively processing tweens?
doDestroy = false;                   // Should we delay the destruction of shared tweener?
firstDestroy = true;                 // Used for handling destructiond code

// Required data structures
tweens = ds_list_create();           // Stores automated step tweens
delayedTweens = ds_list_create();    // Stores tween delay data
simpleTweens = ds_map_create();      // Used for simple tweens
pRoomTweens = ds_map_create();       // Associates persistent rooms with stored tween lists
pRoomDelays = ds_map_create();       // Associates persistent rooms with stored tween delay lists
eventCleaner = ds_priority_create(); // Used to clean callbacks from events
