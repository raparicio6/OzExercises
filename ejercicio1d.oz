local L1 L2 Append in
   Append = fun {$ Xs Ys}
       case Ys of H2|T2 then
	  case Xs of H|T then
	     H|{Append T Ys}
	  else Ys
	  end   
       else Xs
       end
   end

   L1 = [1 2 3 4]
   L2 = [5 6 7 8]
   {Browse {Append L1 L2}}
end