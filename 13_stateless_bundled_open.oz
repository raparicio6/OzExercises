%sin estado abierto empaquetado

declare NewDicc
fun {DiccOps Dicc}
 
   fun {Put Key Val}
      local
         fun {Put2 D Key Val}
            case D of nil then tree(Key Val nil nil)
            [] tree(K V L R) andthen Key== K then tree(Key (V+Val) L R)
            [] tree(K V L R) andthen Key < K then tree(K V {Put2 L Key Val} R)
            [] tree(K V L R) andthen Key > K then tree(K V L {Put2 R Key Val})
            else D
            end
         end
      in 
         case Dicc of nil then {DiccOps tree(Key Val nil nil)}
         [] tree(K V L R) andthen Key== K then {DiccOps tree(Key (V+Val) L R)}
         [] tree(K V L R) andthen Key < K then {DiccOps tree(K V {Put2 L Key Val} R)}
         [] tree(K V L R) andthen Key > K then {DiccOps tree(K V L {Put2 R Key Val})}
         else {DiccOps Dicc}
         end
      end
   end
   
   fun {Get Key}
      local
         fun {Get2 D Key}
            case D of nil then 0
            [] tree(K V L R) andthen Key== K then V
            [] tree(K V L R) andthen Key < K then {Get2 L Key}
            [] tree(K V L R) andthen Key > K then {Get2 R Key}
            else nil
            end
         end
      in
         case Dicc of nil then 0
         [] tree(K V L R) andthen Key== K then V
         [] tree(K V L R) andthen Key < K then {Get2 L Key}
         [] tree(K V L R) andthen Key > K then {Get2 R Key}
         else nil end
      end
   end

   fun {Equals OtroDicc}
      local A B in
         A = {Sort {VirtualString.toString {Value.toVirtualString Dicc 0 0} } Value.'<'}
         B = {Sort {VirtualString.toString {Value.toVirtualString OtroDicc 0 0} } Value.'<'}
         {Browse A}
         {Browse B}
         true
      end
   end
   
in
   ops(put:Put get:Get equals:Equals p:Print)
end

fun {NewDicc}
   {DiccOps nil}
end   


declare D1 D2 D3 D4 D5
D1 = {NewDicc}
%{Browse {D1.get 1}}
D2 = {D1.put 1 1}
%{Browse {D2.get 1}}
D3 = {D2.put 0 1}
%{Browse 3#{D3.get 0}}
%{Browse {D3.get 2}}

D4 = {D3.put 2 1}
D5 = {D4.put 0 1}

{Browse {D4.equals D5}}
%{Browse {D5.equals D5}}

%{Browse {D5.get 0}}
%{Browse {D5.get 1}}
%{Browse {D5.get 2}}
%{Browse {D5.get 3}}
%{Browse {D5.d}}
%{Browse {D5.equals D5}}
