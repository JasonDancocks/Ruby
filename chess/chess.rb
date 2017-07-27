require_relative "pieces"
require_relative "board"

class Player
	attr_accessor :colour

	def initialize(colour)
		@colour = colour
		@current = false
	end
end

class Game

	def initialize
		@board = Board.new
		@player1 = Player.new("white")
		@player2 = Player.new("black")
		@current = @player1
		start_game
	end

	def start_game
		input = ""
		until input == "exit"
			puts "type 'exit' to exit"
			input = gets.chomp
			turn
		end
	end


	def turn
		if @current == @player1
			puts "Player 1's turn (white)"
		else
			puts "Player 2's turn (black)"
		end
		puts "Enter coordinates of piece to move in this format 'x,y'"
		start = gets.chomp.split(",").map! {|x| x.to_i }
		if @board.node_hash[(start)].piece.colour != @current.colour
			puts "This is not your piece!"
		else
			puts "Enter coordinates of square to move to in this format 'x,y'"
			finish = gets.chomp.split(",").map! {|x| x.to_i }
			move(start,finish)
			if @current == @player1
				@current = @player2
			else
				@current = @player1
			end
		end
	end

	def move(start,finish)
		start_node = @board.node_hash[(start)]
		finish_node = @board.node_hash[(finish)]

		if start_node.piece.is_a?(EmptySpace)
			puts "No piece to move at #{start}"
			return
		else

			vector = get_vector(start,finish)
			if valid_move(start_node.piece,vector)
				if check_collision(start, vector)
					@board.node_hash[(finish)].piece = start_node.piece
					@board.node_hash[(start)].piece = EmptySpace.new
					@board.draw_board
				end
			end

		end
	end

	def get_vector(start,finish)
		vector = [finish[0]-start[0],finish[1]-start[1]]
	end

	def valid_move(piece,vector)		
		if piece.moves.include?(vector)
			return true
		else 
			puts "Invalid move, #{piece.icon} cannot move in that way"
		end
	end

	def check_collision(start, vector)
		if @board.node_hash[(start)].piece.is_a?(Knight)
			return true
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
						if check_piece.colour == start_piece.colour 
								puts "Path blocked by #{@board.node_hash[(check)].piece.icon} at (#{check})"
							return false
						elsif
							return true
						end
					end
				end
				return true
			end
		end
	end
end

game = Game.new

