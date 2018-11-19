local NewPortObject Client1 Client2 Show Check Filter in
   fun {NewPortObject Proc}
      local Sin in
	 thread
	    for Msg in Sin do {Proc Msg} end
	 end
	 {NewPort Sin}
      end
   end
   Show = proc {$ Msg}
	     {Browse Msg}
	  end
   fun {Check Msg}
      if (Msg < 30) then
	 true
      else
	 false
      end
   end
   Filter = proc {$ Msg}
	       if {Check Msg} then
		  {Send Client2 Msg}
	       end
	    end
   Client1 = {NewPortObject Filter}
   Client2 = {NewPortObject Show}
   {Send Client1 23}
end
