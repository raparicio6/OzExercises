local Length Xs R X Xr L in
   proc {Length Xs R}
      case Xs of nil then R=0
      [] X|Xr then
	 local U in
	    {Length Xr U}
	    R= U+1
	 end
      end
   end
   L = [1 2 3 4]
   {Browse {Length L}}
end
