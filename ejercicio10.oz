local Mensajes Stop in
   % Agente.
   thread { ForAll Mensajes proc {$ X}
                               {Browse X}
                            end
          }
   end

   Mensajes = ['Hola' 'como' 'estas?' Stop] % 1ra impresion.
   {Time.delay 2000}
   Stop = 'bien y vos?' % 2da impresion.
end