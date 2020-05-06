/// @description uuid_generate()
var d = current_time + epoch() * 10000, uuid = array_create(32), i = 0, r;

for (i=0;i<array_length_1d(uuid);++i) {
    r = floor((d + random(1) * 16)) mod 16;
    
    if (i == 16)
        uuid[i] = dec_to_hex(r & $3|$8);
    else
        uuid[i] = dec_to_hex(r);
}

uuid[12] = "4";

return uuid_array_implode(uuid);


