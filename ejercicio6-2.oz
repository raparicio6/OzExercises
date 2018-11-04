declare fun {Map L F}
           case L
           of nil then nil
           [] X|Xr then {F X}|{Map Xr F}
           end
        end

% Ejemplo de Map.
{Browse {Map [1 2 3 4] fun {$ I} I + 2 end}} % Resultado [3 4 5 6].