/// @description uuid_array_implode()
var s = "", i=0, sl = array_length_1d(argument0), a = argument0, sep = "-";

repeat 8 s += a[i++];
s += sep;

repeat 4 s += a[i++];
s += sep;

repeat 4 s += a[i++];
s += sep;

repeat 4 s += a[i++];
s += sep;

repeat 12 s += a[i++];

return s;


