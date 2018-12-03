%Implementacion con estado, abierta y desempaquetada

local Dic  in
    local
       fun {NewDicc} 
            {NewCell nil}
       end

      fun {Get T Clave}
	     case @T
	     of nil then 0
	     [] tree(K Valor T1 T2) andthen Clave==K then Valor
	     [] tree(K Valor T1 T2) andthen Clave<K then {Get T1 Clave}
	     [] tree(K Valor T1 T2) andthen Clave>K then {Get T2 Clave}
	     end
	  end


	  proc {Put T Clave Valor}
	     case @T
	     of nil then T := tree(Clave Valor {NewDicc} {NewDicc})
	     [] tree(K Valor2 T1 T2) andthen Clave==K then
		T := tree(Clave Valor2+Valor T1 T2)
	     [] tree(K Valor T1 T2) andthen Clave<K then
		{Put T1 Clave Valor}
	     [] tree(K Valor T1 T2) andthen Clave>K then
		{Put T2 Clave Valor}
	     end
	  end
	  


	  fun {Equals D1 D2}
	     {Sort {VirtualString.toString {Value.toVirtualString @D1 0 0} } Value.'<'} == {Sort {VirtualString.toString {Value.toVirtualString @D2 0 0} } Value.'<'}
end
	  
    in
       Dic = dic(new:NewDicc put:Put get:Get equals:Equals)
    end
    local Dic1 Dic2 StringToDic Anagramas Str1 Str2 Str3 Str4 Str5 Str6 in

       fun {StringToDic D S}
       case S of nil then D
      [] H|T then local Res in
		     Res = {Dic.get D H}
		     if Res\=notfound then
		   {Dic.put D H Res+1}
		else
		   {Dic.put D H 1}
		end
		{StringToDic D T}
		  end
      else
	 nil
      end
    end

       fun {Anagramas S1 S2}
	  local D1 D2 in
	     D1 = {StringToDic {Dic.new} S1}
	     D2 = {StringToDic {Dic.new} S2}
	     {Dic.equals D1 D2}
	  end
       end

       {Browse 'Anagram tests'}
       Str1 = "RAMON"
       Str2 = "ABILA"
       Str3 = "LIVES"
       Str4 = "ELVIS"
       Str5 = "PODER"
       Str6 = "PEDRO"
       {Browse {Anagramas Str1 Str2}}
       {Browse {Anagramas Str1 Str3}}
       {Browse {Anagramas Str3 Str4}}
       {Browse {Anagramas Str5 Str6}}
       {Browse {Anagramas Str5 Str3}}
    end   
end
