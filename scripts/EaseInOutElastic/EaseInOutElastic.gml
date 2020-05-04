/// EaseInOutElastic(time,start,change,duration)

var _s = 1.70158;
var _p = 0;
var _a = argument2;
var _val = argument0;

if (_val == 0 || _a == 0) { return argument1; }

_val /= argument3*0.5;

if (_val == 2) { return argument1+argument2; }

if (_p == 0) { _p = argument3 * (0.3 * 1.5); }

if (_a < abs(argument2)) 
{ 
    _a = argument2;
    _s = _p * 0.25;
}
else
{
    _s = _p / (2 * pi) * arcsin (argument2 / _a);
}

if (_val < 1) { return -0.5 * (_a * power(2, 10 * (--_val)) * sin((_val * argument3 - _s) * (2 * pi) / _p)) + argument1; }

return _a * power(2, -10 * (--_val)) * sin((_val * argument3 - _s) * (2 * pi) / _p) * 0.5 + argument2 + argument1;





