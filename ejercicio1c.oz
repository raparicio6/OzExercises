local L1 Length Drop in
    Length = fun {$ Xs}
        case Xs of H|T then 1 + {Length T}
        else 0
        end
    end

    Drop = fun {$ Xs N}
        if N==0 then Xs
        else		 
            case Xs of H|T then
                local Largo in
                    Largo = {Length Xs}
                    if (Largo < N) then nil else {Drop T N-1}
                    end	       
                end
            else 0
            end
        end
    end		    
    L1 = [1 2 3 4 7 6]
    {Browse {Drop L1 4}}
end