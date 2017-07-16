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
			@words = @words.map{|x| x.strip}
		end
	end

	def validate_words
		@valid_words= []

		@words.each do |word|
			if word.length >= 5 && word.length <= 12
				@valid_words << word
			end
		end
		
	end

	def choose_word
		@valid_words.shuffle!

		@target = @valid_words[rand(@valid_words.length-1)]

	end

	def check_letter(input)
		if @target.include? "input"
			return true
		end
		
	end

end

class Player
	attr_accessor :max_turns ,:turn_count, :input, :used_letters, :current_display

	def initialize
		@turn_count = 0
		@max_turns = 12
		@used_letters =[]
	
	end

	def letter?(lookAhead)
		lookAhead =~ /[[:alpha:]]/
	end

	def numeric?(lookAhead)
		lookAhead =~ /[[:digit:]]/
	end

	def valid_input

		if letter?(@input) && !numeric?(@input)
			if letter_used?
				return true
			else
				return false
			end
		end

	end

	def letter_used?
		if @used_letters.include? @input
			puts "Letter already used, please enter a different letter"
			return false
		else
			return true
		end
	end	

	def get_input
		puts "Please enter a letter"
		
		@input = gets.chomp.downcase

		until valid_input
			@input = gets.chomp.downcase
		end

		@used_letters << @input
	end

	def calculate_display(target)
		answer_array = []
		chr = 0
		p target.length
		while 0 <target.length
			if @used_letters.include? target[chr]
				answer_array[chr] = target[chr]
			
			else
				answer_array[chr] = "_"
			
			end
			chr += 1
			
		end

		answer_string = answer_array.join

		puts "#{answer_string} || #{@used_letters}"
	end


	def turn(target)
		
		get_input
		calculate_display(target)

		@turn_count += 1
		puts "Remaning guesses : #{@max_turns - @turn_count}"
	end
end


game = Hangman.new
player = Player.new

until player.turn_count > player.max_turns
player.turn(game.target)
end




