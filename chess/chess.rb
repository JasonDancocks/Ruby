require_relative "pieces"
require_relative "board"

class Player
	attr_accessor :colour, :check

	def initialize(colour)
		@colour = colour
		@check = false
	end
end

class Game

	def initialize
		@board = Board.new
		@king_white_location = [3,0]
		@king_black_location = [3,7]
		@player1 = Player.new("white")
		@player2 = Player.new("black")
		@current = @player1
		@game_over = false
		start_game
	end

	def start_game	
		until @game_over == true
			turn
		end
		puts "Press 1 to play again or 2 to exit"
		input = gets.chomp
		if input == "1"
			game = Game.new
		elsif input == "2"
			exit
		else
			start_game
		end
	end

	def get_piece_positions
		positions = @board.node_hash.keys
		positions.delete_if {|pos| @board.node_hash[(pos)].piece.is_a?(EmptySpace)}
		return positions
	end

	def get_white_positions(positions)
		positions_white = positions.delete_if {|pos| @board.node_hash[(pos)].piece.colour == "black"}
	end

	def get_black_positions(positions)
		positions_black = positions.delete_if {|pos| @board.node_hash[(pos)].piece.colour == "white"}
	end

	def in_check	
		positions_black = get_black_positions(get_piece_positions)
		positions_black.each do |pos|
			vector = get_vector(pos,@king_white_location)
			piece = @board.node_hash[(pos)].piece
			if piece.is_a?(Pawn)
				if piece.attack_moves.include?(vector)
					puts "White king is in check! from #{pos}"
					@player1.check = true
				end
			elsif piece.moves.include?(vector)
				if check_collision(pos,@king_white_location)
					puts "White king is in check! from #{pos}"
					@player1.check = true
				end
			else
		end

		positions_white = get_white_positions(get_piece_positions)
		positions_white.each do |pos|
			vector = get_vector(pos,@king_black_location)
			piece = @board.node_hash[(pos)].piece
			if piece.is_a?(Pawn)
				if piece.attack_moves.include?(vector)
					puts "Black king is in check! from #{pos}"
					@player2.check = true		
				end
			elsif piece.moves.include?(vector)
				if check_collision(pos,@king_black_location)
					puts "Black king is in check! from #{pos}"
					@player2.check = true
				end
			end
		end

	end

	def turn
		if @current == @player1
			puts "Player 1's turn (white)"
		else
			puts "Player 2's turn (black)"
		end
		puts "Which piece do you want to move?"
		start = get_input
		if @board.node_hash[(start)].piece.colour != @current.colour
			puts "This is not your piece!"
			turn
		else
			puts "Where do you want to move to?"
			finish = get_input
			until move(start,finish)
				if get_input == "change"
					return
				else
					finish = get_input
				end
			end
			in_check
			if @current == @player1		
				@current = @player2
			else
				@current = @player1
			end
		end
	end

	def get_input
		puts "Enter coordinates in this format 'x,y'"
		input = gets.chomp
		if input == "change"
			return input
		elsif valid_input(input)
			input = input.split(",").map! {|x| x.to_i }
			return input
		else
			puts "Invalid input"
			get_input
		end
	end

	def valid_input(input)
		if input =~ /\d,\d/
			input = input.split(",").map! {|x| x.to_i }
			if input[0] < 8 && input[0] >= 0
				if input[1] < 8 && input[1] >= 0
					return true
				end
			end
		end
	end

	def move(start,finish)
		start_node = @board.node_hash[(start)]
		finish_node = @board.node_hash[(finish)]
		vector = get_vector(start,finish)
		if start_node.piece.is_a?(Pawn)
			if valid_move_pawn(start,start_node.piece,vector)		
				update_board(start,finish)
				return true
			end
		else
			if valid_move(start_node.piece,vector)
				if check_collision(start, finish)
					update_board(start,finish)
					return true
				end
			end
		end
	end

	def update_board(start,finish)
		@board.node_hash[(finish)].piece = @board.node_hash[(start)].piece
		if @board.node_hash[(finish)].piece.is_a?(King)
			if @board.node_hash[(finish)].piece.colour == "white"
				@king_white_location = finish
			else
				@king_black_location = finish
			end
		end
		@board.node_hash[(start)].piece = EmptySpace.new
		@board.draw_board
	end

	def get_vector(start,finish)	
		vector = [finish[0]-start[0],finish[1]-start[1]]
	end

	def valid_move(piece,vector)	
		if piece.moves.include?(vector)
			return true
		else
			puts "Invalid move, #{piece.icon}  cannot move in that way"
		end
	end

	def valid_move_pawn(start,piece,vector)
		target = [start[0]+vector[0],start[1]+vector[1]]
		if piece.is_first_move == true
			if piece.first_moves.include?(vector)
				if check_collision_pawn_move(start,target)			
					piece.is_first_move = false
					p piece.is_first_move
					return true
				end
			else
				puts "Invalid move, #{piece.icon} cannot move in that way"
			end
		elsif piece.moves.include?(vector)
			if check_collision_pawn_move(start,target)
				return true
			end
		elsif piece.attack_moves.include?(vector)
			if @board.node_hash[(target)].piece.colour != piece.colour
				if @board.node_hash[(target)].piece.is_a?(EmptySpace)
					puts "Invalid move, #{piece.icon} can only attack in that way"
					return false
				end
				return true
			end
		else
			puts "Invalid move, #{piece.icon} cannot move in that way"
		end
	end

	def check_collision_pawn_move(start,target)
		unless @board.node_hash[(target)].piece.is_a?(EmptySpace)
			puts "Path blocked by #{@board.node_hash[(target)].piece.icon} at (#{target})"
			return false
		end
		return true
	end

	def check_collision(start, finish)
		vector = get_vector(start,finish)
		if @board.node_hash[(start)].piece.is_a?(Knight)
			if @board.node_hash[(finish)].piece.colour != @board.node_hash[(start)].piece.colour 
				return true
			end
		else	
			x, y = 0, 0
			until x == vector[0]  && y == vector[1] 
				if vector[0] < 0
					if x > vector[0]
						x -= 1
					end
				elsif vector[0] >= 0
					if x < vector[0]
						x +=1
					end
				end
				if vector[1] < 0
					if y > vector[1]
						y -=1
					end
				elsif vector[1] >= 0
					if y < vector[1]
						y +=1
					end
				end	
				check = [start[0] + x, start[1]+y]
				if check == start
					next
				else
					start_piece = @board.node_hash[(start)].piece
					check_piece =	@board.node_hash[(check)].piece
					unless check_piece.is_a?(EmptySpace)
						if check == finish
							if check_piece.colour == start_piece.colour 
								unless @board.node_hash[(finish)].piece.is_a?(King)
									puts "Path blocked by #{@board.node_hash[(check)].piece.icon} at (#{check})"
								end
								return false
							end
						else
							unless @board.node_hash[(finish)].piece.is_a?(King)
								puts "Path blocked by #{@board.node_hash[(check)].piece.icon} at (#{check})"
							end
							return false
						end
					end				
				end
			end
			return true
		end
	end
end




game = Game.new

