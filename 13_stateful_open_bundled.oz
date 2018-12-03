% Con estado, abierto y empaquetado

local Dic  in


fun {Dic}
   C = {NewCell hoja}
   proc {Put Clave Valor}
      local
      fun {Put2 D Clave Valor}
	 case D of hoja then t(Clave Valor hoja hoja)
	 [] t(Clave2 V T1 T2) andthen Clave==Clave2 then t(Clave Valor T1 T2)
	 [] t(Clave2 V T1 T2) andthen Clave < Clave2 then t(Clave2 V {Put2 T1 Clave Valor} T2)
	 [] t(Clave2 V T1 T2) andthen Clave > Clave2 then t(Clave2 V T1 {Put2 T2 Clave Valor})
	 else nil
	 end
      end
      in
      C:= {Put2 @C Clave Valor}
      end
      
   end
   fun {Get Clave}
      local
	 fun {Get2 D Clave}
	      case D of hoja then notfound
	      [] t(Clave2 V T1 T2) andthen Clave==Clave2 then V
	      [] t(Clave2 V T1 T2) andthen Clave<Clave2 then {Get2 T1 Clave}
	      [] t(Clave2 V T1 T2) andthen Clave>Clave2 then {Get2 T2 Clave}
	      else nil
	      end
	   end
	in
	   {Get2 @C Clave}
      end
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
   ops(put:Put get:Get getId: GetId equals:Equals)
end

local StringToDic Anagramas Str1 Str2 Str3 Str4 in

   fun {StringToDic D S}
      case S of nil then D
      [] H|T then local Res in
		Res = {D.get H}
		if Res\=notfound then
		   {D.put H Res+1}
		else
		   {D.put H 1}
		end
		{StringToDic D T}
	     end
      else
	 nil
      end
   end

   fun {Anagramas S1 S2}
      local D1 D2 in
	 D1 = {StringToDic {Dic} S1}
	 D2 = {StringToDic {Dic} S2}
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
   
end
end
