local L1 L2 Length Take in
    Length = fun {$ Xs}
        case Xs of H|T then 1 + {Length T}
        else 0
        end
    end

    Take = fun {$ Xs N}
        if N==0 then nil
        else		 
            case Xs of H|T then
                local Largo in
                    Largo = {Length Xs}
                    if (Largo < N) then Xs else H|{Take T N-1}
                    end	       
                end
            else 0
            end
        end
    end		    
    L1 = [1 2 3 4 7 6]
    L2 = {Take L1 4}
    {Browse L2}
end