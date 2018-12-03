local Dic NewWrapper in
   proc {NewWrapper ?Wrap ?Unwrap}
      local Key = {NewName} in
	 fun {Wrap X}
            fun {$ K} if (K == Key) then X end end
	 end
	 fun {Unwrap W} {W Key} end
      end
   end

   local Wrap Unwrap in
      local
         {NewWrapper Wrap Unwrap}

         fun {NewDicc} {Wrap nil} end

         fun {Put T K V}
            case {Unwrap T}
            of nil then {Wrap tree(K V {NewDicc} {NewDicc})}
            [] tree(Y W T1 T2) andthen K == Y then
               {Wrap tree(K W + V T1 T2)}
            [] tree(Y W T1 T2) andthen K < Y then
               {Wrap tree(Y W {Put T1 K V} T2)}
            [] tree(Y W T1 T2) andthen K > Y then
               {Wrap tree(Y W T1 {Put T2 K V})}
            end
         end

         fun {Get T K}
            case {Unwrap T}
            of nil then 0
            [] tree(Y V T1 T2) andthen K == Y then V
            [] tree(Y V T1 T2) andthen K < Y then {Get T1 K}
            [] tree(Y V T1 T2) andthen K > Y then {Get T2 K}
            end
         end

         fun {KeyValuePairs T}
            case {Unwrap T}
            of nil then nil
            [] tree(K V nil nil) then pair(K V)
            [] tree(K V T1 nil) then {Append {KeyValuePairs T1} [pair(K V)]}
            [] tree(K V nil T2) then{Append [pair(K V)] {KeyValuePairs T2}}
            [] tree(K V T1 T2) then {Append {Append {KeyValuePairs T1} [pair(K V)]} {KeyValuePairs T2}}
            end
         end

         fun {Equals X Y}
            {Sort {VirtualString.toString {Value.toVirtualString {KeyValuePairs X} 0 0} } Value.'<'} ==
            {Sort {VirtualString.toString {Value.toVirtualString {KeyValuePairs Y} 0 0} } Value.'<'}
         end
      in
         Dic = dic(new:NewDicc put:Put get:Get equals:Equals)
      end
   end

   local StringToDic Anagramas Str1 Str2 Str3 Str4 Str5 Str6 Str7 Str8 Str9 in
      fun {StringToDic D S}
         case S of nil then D
         [] H|T then {Dic.put {StringToDic D T} H 1}
         else {Dic.put D S 1} end
      end

      fun {Anagramas S1 S2}
         {Dic.equals {StringToDic {Dic.new} S1} {StringToDic {Dic.new} S2}}
      end

      {Browse 'Anagram tests'}
      Str1 = "RAMON"
      Str2 = "ABILA"
      Str3 = "LIVES"
      Str4 = "ELVIS"
      Str5 = "PODER"
      Str6 = "PEDRO"
      Str7 = "OOP"
      Str8 = "POO"
      Str9 = "OP"
      {Browse {Anagramas Str1 Str2}} % Debe ser false.
      {Browse {Anagramas Str1 Str3}} % Debe ser false.
      {Browse {Anagramas Str3 Str4}} % Debe ser true.
      {Browse {Anagramas Str5 Str6}} % Debe ser true.
      {Browse {Anagramas Str5 Str3}} % Debe ser false.
      {Browse {Anagramas Str7 Str8}} % Debe ser true.
      {Browse {Anagramas Str7 Str9}} % Debe ser false.

      {Browse 'Other tests'}
      {Browse {Dic.get {Dic.put {Dic.new} 5 '5'} 5}} % Debe ser '5'.
      {Browse {Dic.equals {Dic.put {Dic.new} 5 '5'} {Dic.new}}} % Debe ser false.
      {Browse {Dic.equals {Dic.put {Dic.new} 5 '5'} {Dic.put {Dic.new} 5 '5'}}} % Debe ser true.
   end
end