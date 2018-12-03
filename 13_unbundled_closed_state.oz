local Dic Wrapper in
   proc {Wrapper ?Wrap ?Unwrap}
      local K = {NewName} in
	 fun {Wrap W} fun {$ X} if (X == K) then W end end end
	 fun {Unwrap W} {W K} end
      end
   end

   local Wrap Unwrap in
      local
	 {Wrapper Wrap Unwrap}

         fun {NewDicc} {Wrap {NewCell nil}} end

         proc {Put T K V}
	    UnwrappedTree = {Unwrap T} in
	    case @UnwrappedTree
	    of nil then UnwrappedTree := tree(K V {NewDicc} {NewDicc})
	    [] tree(X Y T1 T2) andthen K == X then
	       UnwrappedTree := tree(K Y + V T1 T2)
	    [] tree(X Y T1 T2) andthen K < X then
	       {Put T1 K V}
	    [] tree(X Y T1 T2) andthen K > X then
	       {Put T2 K V}
	    end
	 end

	 fun {Get T K}
	    case @{Unwrap T}
	    of nil then 0
	    [] tree(X Y T1 T2) andthen K == X then Y
	    [] tree(X Y T1 T2) andthen K < X then {Get T1 K}
	    [] tree(X Y T1 T2) andthen K > X then {Get T2 K}
	    end
	 end

         fun {KeyValuePairs T}
	    case @{Unwrap T}
            of nil then nil
            [] tree(X Y nil nil) then pair(X Y)
            [] tree(X Y T1 nil) then {Append {KeyValuePairs T1} [pair(X Y)]}
            [] tree(X Y nil T2) then {Append [pair(X Y)] {KeyValuePairs T2}}
            [] tree(X Y T1 T2) then {Append {Append {KeyValuePairs T1} [pair(X Y)]} {KeyValuePairs T2}}
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
         [] H|T then {Dic.put D H 1} {StringToDic D T}
         end
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
   end
end
