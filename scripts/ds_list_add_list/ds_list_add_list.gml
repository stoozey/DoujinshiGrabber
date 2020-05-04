///@desc ds_list_add_list(id,list)
///@arg id
///@arg list

var parent, list, pos;
parent = argument0;
list = argument1;

pos = ds_list_size(parent);
ds_list_add(parent, list);
ds_list_mark_as_list(parent, pos);