//Checks if we have pressed the enter key.
if(keyboard_check_pressed(vk_enter)){

    //Opens the folder browser dialog and sets the root folder and description.
    var dir = zdir_get_directory("C:\\", "Choose a folder.");
    
    //Displays a message with the returned folder path.
    show_message(dir);
    
    //Clears the key-state.
    //This is needed because for some reason Game Maker doesn't clear the
    //key-state after closing the folder dialog, which means that the key
    //would still be pressed down even if we aren't actually doing it.
    //This also applies when with mouse clicks. Use mouse_clear for that.
    keyboard_clear(vk_enter);

}

