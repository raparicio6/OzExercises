local Length L in
   Length = fun {$ Xs}
      case Xs of H|T then 1 + {Length T}
      else 0
      end
   end
   L = [1 2 3 4 7 6]
   {Browse {Length L}}
end