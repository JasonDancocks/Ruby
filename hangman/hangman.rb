require "json"

class Hangman
	attr_accessor :max_turns, :target, :used_letters, :turn_count, :current_display, :input

	def initialize
		@max_turns = 12
		@used_letters = []
		load_dictionary
		@valid_words = validate_words
		choose_word	
		start	
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

	def letter?(lookAhead)
		lookAhead =~ /[[:alpha:]]/
	end

	def numeric?(lookAhead)
		lookAhead =~ /[[:digit:]]/
	end

	def letter_used?
		if @used_letters.include? (@input)
			return false
		else
			return true
		end
	end

	def valid_input
		if @input.length == 1
			if letter?(@input) && !numeric?(@input)
				if letter_used?	
					return true
				else
					return false
				end
			end
		end
	end

	def save
		fname = filename
		puts "Saving.."
		until check_filename(fname)
		end
		File.open(fname, "w"){ |file|file.puts to_json}
		puts "Game Saved!"
		continue
	end

	def filename
		puts "Enter filename"
		fname = gets.chomp.downcase.split(".")
		fname = fname[0].to_s
		fname << ".txt"
	end

	def check_filename(fname)
		if File.exist?(fname)
			puts "File #{fname} already exists, overwrite? y / n"
			until input == "y" or input == "n"
				input = gets.chomp.downcase
				if input == "y"
					return true
				elsif input == "n"
					save
				end
			end
		else
			return true
		end
	end

	def to_json
		JSON.dump ({
			:target => @target,
			:used_letters => @used_letters,
			:turn_count => @turn_count,
			:current_display => @current_display
			})
	end

	def continue
		puts "Continue playing?"
		puts "Press 1 to continue, 2 to exit"
		input = gets.chomp
		if input == "1"
			calculate_display
			turn		
		elsif input == "2"
			puts "Thanks for Playing!"
			exit
		else
			continue
		end
	end

	def load
		fname = filename
		if File.exist?(fname)
			savefile = File.open(fname, "r"){|file| file.read}
		else
			puts "Error : File not found"
			load
		end
		puts "Loading"
		from_json(savefile)
		puts "Load Complete!"
	end

	def from_json(string)
		data = JSON.parse(string)
		@target = data["target"]
		@used_letters = data["used_letters"]
		@turn_count = data["turn_count"]
		@current_display = data["current_display"]
	end

	def get_input
		puts "Please enter a letter"
		@input = gets.chomp.downcase
		if input == "save"
			save
		elsif input == "load"
			load
		else
			until valid_input
				puts "Please enter a letter"
				@input = gets.chomp.downcase
			end
			@used_letters << @input
		end
	end

	def calculate_display
		answer_array = []
		chr = 0
		while chr <@target.length
			if @used_letters.include? @target[chr]
				answer_array[chr] = @target[chr]
			else
				answer_array[chr] = "_"
			end
			chr += 1
		end
		@current_display = answer_array.join
		puts "#{@current_display} || #{@used_letters}"
	end

	def check_for_win
		if @current_display.include? "_"
			return false
		else
			return true
		end
	end

	def turn
		get_input
		calculate_display
		if check_for_win
			puts "You win! You guessed the word in #{@turn_count} guesses!"
			@turn_count = @max_turns 
		else
			puts "Remaning guesses : #{@max_turns - @turn_count - 1}"
			@turn_count += 1
		end
	end

	def play_again
		puts "Press 1 to play again or 2 to exit"
		input = gets.chomp
		if input == "1"
			game = Hangman.new
		elsif input == "2"
			puts "Thanks for Playing!"
			exit
		else
			play_again
		end
	end


	def start
		puts "Welcome to Hangman!"
		puts "Please enter \"save\" or \"load\" at any point to perfom those actions"
		calculate_display
		@turn_count = 0
		until @turn_count > @max_turns -1
			turn
		end
		unless check_for_win
			puts "You lose! The word was #{@target}"
		end
		play_again
	end
end


game = Hangman.new