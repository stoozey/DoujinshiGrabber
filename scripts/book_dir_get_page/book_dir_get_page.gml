///@arg book
///@arg page num
///@arg temp

var _baseDir;
_baseDir = (argument2) ? DIR_TEMP : DIR_IMAGES;

return (_baseDir + argument0.dirImages + "\\" + string(max(argument1, 1)) + ".jpg");