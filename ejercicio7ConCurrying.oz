local Suma N1 N2 in
   Suma = fun {$ N1}
	     fun {$ N2}
		N1+N2
	     end
	  end
   {Browse {{Suma 3} 2}}
end
