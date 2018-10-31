local Length Xs Acum R X Xr L in
   proc {Length Xs Acum R}
      case Xs of nil then R=Acum
      [] X|Xr then
	 {Length Acum+1 R}
      end
   end
end
