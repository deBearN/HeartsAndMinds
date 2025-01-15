_HQs = [hq_base,hq_cerimonial,hq_final];

{
if (_x != hq_base) then {_x addAction ["Ir para a Base Principal","scripts\teleporter.sqf",["base"]];};
if (_x != hq_cerimonial) then {_x addAction ["Ir para - Cerimonial","scripts\teleporter.sqf",["cerimonial"]];};
if (_x != hq_final) then {_x addAction ["Ir para - Prova Final","scripts\teleporter.sqf",["final"]];};
} forEach _HQs;