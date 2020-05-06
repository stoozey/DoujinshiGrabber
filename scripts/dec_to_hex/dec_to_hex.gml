/// @description  dec_to_hex(dec)
/// @param dec
//
//  Returns a string of hexadecimal digits (4 bits each)
//  representing the given decimal integer. Hexadecimal
//  strings are padded to byte-sized pairs of digits.
//
//      dec         non-negative integer, real
//
/// GMLscripts.com/license
// has been adapted
{
    var dec, hex, h, byte, hi, lo;
    dec = argument0;
    if (dec) hex = "" else hex="0";
    h = "0123456789ABCDEF";
    while (dec) {
        byte = dec & 255;
        hi = string_char_at(h, byte div 16 + 1);
        lo = string_char_at(h, byte mod 16 + 1);
        hex = iff(hi!="0", hi, "") + lo + hex;
        dec = dec >> 8;
    }
    return hex;
}

