declare fun {FoldL L F U}
           case L
           of nil then U
           [] X|Xr then {FoldL Xr F {F X U}}
           end
        end

declare fun {FoldR L F U}
           case L
           of nil then U
           [] X|Xr then {F X {FoldR Xr F U}}
           end
        end


% Funcion auxiliar.
fun {S X Y}
   X|Y
end

% Ejemplo FoldL.
{Browse {FoldL ['a' 'b' 'c' 'd'] S 'e'}} % Resultado d|c|b|a|e.

% Ejemplo FoldR.
{Browse {FoldR ['a' 'b' 'c' 'd'] S 'e'}} % Resultado a|b|c|d|e.
