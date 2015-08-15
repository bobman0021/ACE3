/*
 * Author: Dslyecxi, MikeMatrix
 * Initializes Settings for the groups modules and transcodes settings to a useable format.
 *
 * Arguments:
 * 0: Logic <LOGIC>
 * 1: Units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [module, [player], true] call ace_map_gestures_fnc_moduleGroupSettings
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic", "_units", "_activated"];

diag_log "Running";

if (!_activated) exitWith {};
if (!isServer) exitWith {};

_leadColor = call compile ("[" + (_logic getVariable ["leadColor", ""]) + "]");
if (!([_leadColor] call FUNC(isValidColorArray))) exitWith {ERROR("leadColor is not a valid color array.")};
_color = call compile ("[" + (_logic getVariable ["color", ""]) + "]");
if (!([_color] call FUNC(isValidColorArray))) exitWith {ERROR("color is not a valid color array.")};

_configurations = if (isNil QGVAR(GroupColorConfigurations)) then { [] } else { +GVAR(GroupColorConfigurations) };
_configurationGroups = if (isNil QGVAR(GroupColorConfigurationsGroups)) then { [] } else { +GVAR(GroupColorConfigurationsGroups) };
_configurationGroupsIndex = if (isNil QGVAR(GroupColorConfigurationsGroupIndex)) then { [] } else { +GVAR(GroupColorConfigurationsGroupIndex) };

_completedGroups = [];
_configurationIndex = _configurations pushBack [_leadColor, _color];
{
    private "_group";
    _group = groupID (group _x);
    if (!(_group in _completedGroups)) then {
        _index = if (_group in _configurationGroups) then {_configurationGroups find _group} else {_configurationGroups pushBack _group};
        _configurationGroupsIndex set [_index, _configurationIndex];
        _completedGroups pushBack _group;
    };
    nil
} count _units;

[QGVAR(GroupColorConfigurations), _configurations, true, true] call EFUNC(common,setSetting);
[QGVAR(GroupColorConfigurationsGroups), _configurationGroups, true, true] call EFUNC(common,setSetting);
[QGVAR(GroupColorConfigurationsGroupIndex), _configurationGroupsIndex, true, true] call EFUNC(common,setSetting);