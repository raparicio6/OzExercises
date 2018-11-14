local Reverse1 Reverse2 L L1 in
   fun lazy {Reverse1 S}
      fun{Rev S R}
	 case S of nil then R
	 [] X|S2 then {Rev S2 X|R} end
      end
   in {Rev S nil} end
   fun lazy {Reverse2 S}
      fun lazy {Rev S R}
	 case S of nil then R
	 [] X|S2 then {Rev S2 X|R} end
      end
   in {Rev S nil} end
   L= [1 2 3 4]
   L1 = {Reverse1 L}
   {Browse L1.1}
end
