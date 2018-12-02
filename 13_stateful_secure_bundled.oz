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

   local D D2 D3 StringToDic Anagramas Str1 Str2 Str3 Str4 in

   fun {StringToDic D S}
      case S of nil then D
      [] H|T then local Res in
		Res = {D.get H}
		if Res\=notfound then
		   {D.put H Res+1}
		else
		   {D.put H 0}
		end
		{StringToDic D T}
	     end
      else
	 nil
      end
   end

   fun {Anagramas S1 S2}
      local D1 D2 in
	 D1 = {StringToDic {NewDicc} S1}
	 D2 = {StringToDic {NewDicc} S2}
	 {D1.equals D2}
      end
   end
   {Browse 'Anagram tests'}
   Str1 = "TOMMARVOLORIDDLE"
   Str2 = "IAMLORDVOLDEMORT"
   Str3 = "ELVIS"
   Str4 = "LIVES"
   {Browse {Anagramas Str1 Str2}}
   {Browse {Anagramas Str1 Str3}}
   {Browse {Anagramas Str3 Str4}}
   
   {Browse 'Other random tests'}
%tests
   D={NewDicc}
   {Browse D}
   {Browse {D.get 1}}
   {D.put 1 'one'}
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