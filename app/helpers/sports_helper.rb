module SportsHelper

	def open_to_who(who)
	    if who == "boys" or who == "girls"
	      "Open to #{who} only"
	    else
	      "Open to boys and girls"
	    end
  	end

  	def date_format(date)
  		date.strftime("%B %d, %Y")
  	end

end
