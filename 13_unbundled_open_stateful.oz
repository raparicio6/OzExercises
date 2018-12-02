local Dic  in
    local
       fun {NewDicc} {NewCell nil} end

      fun {Get T Key}
	     case @T
	     of nil then 0
	     [] tree(K V T1 T2) andthen Key==K then V
	     [] tree(K V T1 T2) andthen Key<K then {Get T1 Key}
	     [] tree(K V T1 T2) andthen Key>K then {Get T2 Key}
	     end
	  end


	  proc {Put T Key Value}
	     case @T
	     of nil then T := tree(Key Value {NewDicc} {NewDicc})
	     [] tree(K V T1 T2) andthen Key==K then
		T := tree(Key V+Value T1 T2)
	     [] tree(K V T1 T2) andthen Key<K then
		{Put T1 Key Value}
	     [] tree(K V T1 T2) andthen Key>K then
		{Put T2 Key Value}
	     end
	  end
	  


	  fun {Equals D1 D2}
	     {Sort {VirtualString.toString {Value.toVirtualString @D1 0 0} } Value.'<'} == {Sort {VirtualString.toString {Value.toVirtualString @D2 0 0} } Value.'<'}
	  end
	  
    in
       Dic = dic(new:NewDicc put:Put get:Get equals:Equals)
    end
    local Dic1 Dic2 in
       Dic1 = {Dic.new}
       {Dic.put Dic1 5 '5'}
       {Browse Dic1}
       {Browse {Dic.get Dic1 5}}
       Dic2 = {Dic.new}
       {Browse {Dic.equals Dic1 Dic2}}
       {Dic.put Dic2 5 '5'}
       {Browse {Dic.equals Dic1 Dic2}}
       {Browse {Dic.equals Dic1 Dic1}}

       {Dic.put Dic1 1 '1'}
       {Browse {Dic.equals Dic1 Dic2}}
       {Dic.put Dic2 1 '1'}
       {Browse {Dic.equals Dic1 Dic2}}
    end
    
end