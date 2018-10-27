local L1 Member in
   Member = fun{$ Xs Y}
       case Xs of H|T then
	  if(H==Y) then true else {Member T Y} end
       else false
       end
   end
   L1 = [1 2 3 4]
   {Browse {Member L1 9}}
end