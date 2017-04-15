/*
 * Author: Ruthberg
 * Calculates the range card output based on the current data set
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * call ace_atragmx_fnc_calculate_range_card
 *
 * Public: No
 */
#include "script_component.hpp"

GVAR(rangeCardData) = [];

private _targetRange = GVAR(rangeCardEndRange);
if (GVAR(currentUnit) == 1) then {
    _targetRange = _targetRange / 1.0936133;
};

private _solutionInput = +GVAR(targetSolutionInput);
_solutionInput set [ 8, round(_solutionInput select 4)];
_solutionInput set [13, _targetRange];
_solutionInput set [17, true];

private _result = _solutionInput call FUNC(calculate_solution);
