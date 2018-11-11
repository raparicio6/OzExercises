declare proc {WaitSome L}
	   local C in
	      {ForAll L proc {$ X}
			   thread {WaitOr X C} C=1 end
			end}
	      {Wait C}
	   end
	end

local A B C D E F in
   thread % T1.
      {WaitSome [A B C]}
      {Browse 'Nunca termina!'}
   end

   thread % T2.
      {WaitSome [D E F]}
      {Browse 'Termino!'}
   end

   E = 10 % Termina la ejecucion de T2.
end