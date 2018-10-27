local L1 Position in
   Position = fun{$ Xs Y}
		 case Xs of H|T then
		    if (H==Y) then 1 else 1+{Position T Y} end
		 else 0
		 end
	      end
   
   L1 = [6 5 8 7]
   {Browse {Position L1 5}}
end
