local Length Xs X Xr L in
   fun {Length Xs}
      case Xs of nil then 0
      [] X|Xr then 1+{Length Xr}
      end
   end
   L = [1 2 3 4]
   {Browse {Length L}}
end
