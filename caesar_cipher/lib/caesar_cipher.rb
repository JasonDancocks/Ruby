def caesar_cipher(text, shift) 
	
	letters = text.split("")
	
	letters.map! do |w|
		if( w !=" " && w != "!" && w != "?" && w != "," && w != ".")
			if( w.ord + shift > 122)
				i = (w.ord + shift) - 123  
				w = 97 + i
			else
				w = w.ord + shift
			end			
			w = w.chr
		end

		w.to_s.downcase
		
	end

	output = letters.join("")


	puts output


end

caesar_cipher("what a string!",5)

