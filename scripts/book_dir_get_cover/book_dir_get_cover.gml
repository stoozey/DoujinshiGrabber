///@arg book
///@arg temp

var _baseDir;
_baseDir = (argument1) ? DIR_TEMP : get_image_dir();

return (_baseDir + argument0.dirImages + "\\_cover.jpg");