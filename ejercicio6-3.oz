declare fun {Filter L F}
           case L
           of nil then nil
           [] X|Xr then
              if {F X} then
                 X | {Filter Xr F}
              else
                 {Filter Xr F}
              end
           end
        end

% Ejemplo de Filter.
{Browse {Filter [6 3 7 5 9 12 1] fun {$ A} A>5 end}} % Resultado [6 7 9 12].