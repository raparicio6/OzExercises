%Implementacion con estado, seguro y empaquetado

local NewDicc in

   
   fun {NewDicc}
      C={NewCell leaf}
      proc {Put Key Val}
	 fun {Put2 D Key Val}
	    case D of leaf then tree(Key Val leaf leaf)
	    [] tree(K V T1 T2) andthen Key==K then tree(Key Val T1 T2)
	    [] tree(K V T1 T2) andthen Key < K then tree(K V {Put2 T1 Key Val} T2)
	    [] tree(K V T1 T2) andthen Key > K then tree(K V T1 {Put2 T2 Key Val})
	    else nil
	    end
	 end
      in
	 C:= {Put2 @C Key Val}
      end
      fun {Get Key}
	 fun {Get2 D Key}
	    case D of leaf then notfound
	    [] tree(K V T1 T2) andthen Key==K then V
	    [] tree(K V T1 T2) andthen Key<K then {Get2 T1 Key}
	    [] tree(K V T1 T2) andthen Key>K then {Get2 T2 Key}
	    else nil
	    end
	 end
     in
	 {Get2 @C Key}
      end
  
    fun {GetId}
        {Sort {VirtualString.toString {Value.toVirtualString @C 0 0} } Value.'<'}
    end

    fun {Equals D2}
       local X Y in
	  X = {D2.getId}
	  Y = {GetId}
	  X == Y
       end
    end
    
in
   ops(put:Put get:Get equals: Equals getId: GetId)
end

local D D2 D3 in
   D={NewDicc}
   {Browse D}
   {Browse {D.get 1}}
   {D.put 1 'one'}
   {Browse D}
   {D.put 3 'three'}
   {Browse {D.get 1}}
   
   {D.put 8 'eight'}
   {D.put 0 'zero'}
   {Browse {D.get 0}}
   {D.put 9 'nine'}
   {Browse {D.equals D}}

   D2 = {NewDicc}
   {D2.put 1 'one'}
   {D2.put 3 'three'}
   {D2.put 8 'eight'}
   {D2.put 0 'zero'}
   {Browse {D.equals D2}}
   {D2.put 9 'nine'}
   {Browse {D.equals D2}}
   {Browse {D2.equals D}}

end
end