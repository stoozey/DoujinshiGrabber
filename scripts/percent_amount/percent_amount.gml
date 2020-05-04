// @stoozey_

///@arg num1
///@arg num2
///@arg out_of
///@arg decrease
/*

	n1 - your X amount
	n2 - your Y amount
	out_of - what a 100% value would equal
	decrease -
		false: returns the percentage that X is of Y (example: percent_amount(25, 100, 100, false) returns 25)
		true: returns the percent that X ISN'T of Y  (example: percent_amount(25, 100, 100, true) returns 75)
	
*/

var _n1, _n2, _outOf, _decrease;
_n1					= argument0;
_n2					= argument1;
_outOf			= argument2;
_decrease	= argument3;

var _range;
_range = _n2 - _n1;

var _percent, _adjustedPercent, _finalPercentage;
_percent					= ((_range / _n2 * 100) / 100)	//	the percentage from a range of 0 to 1
_adjustedPercent = _percent * _outOf;					//	the percentage from a range of 0 to out_of
_finalPercentage = (_decrease) ? _adjustedPercent : _outOf - _adjustedPercent;
return _finalPercentage;