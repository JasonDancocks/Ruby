class Hangman
	attr_accessor :words, :valid_words, :target

	def initialize
		load_dictionary
		@valid_words = validate_words
		choose_word
	end

	def load_dictionary
		if File.exist? "5desk.txt"
			@words = File.readlines '5desk.txt'
		end
	end

	def validate_words
		@valid_words = []

		@words.collect do |word|
			word = word.strip
			if word.length >= 5 && word.length <= 12
				@valid_words << word
			end
		end
	end

	def choose_word
		@valid_words.shuffle!

		@target = @valid_words
		#@valid_words[rand(@valid_words.length-1)]
	end

end

class Player
	attr_accessor :turn_count


end


game = Hangman.new

p game.valid_words


p game.target