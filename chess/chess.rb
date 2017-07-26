require_relative "pieces"
require_relative "board"

class Game
	def initialize
		@board = Board.new
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

	def check_collision(start,vector)
		x = start[0]
		y = start[1]
		# wrong approach here, need to redo
		until x == vector[0] && y == vector[1]
			unless start == [x,y]
				unless @board.node_hash[([x,y])].is_a?(EmptySpace)
					puts "Path blocked by #{@board.node_hash[([x,y])].piece.icon} at (#{x},#{y})"
					return false
				end
			end

			unless x == vector[0] 
			
				x += 1
		
			end
		
			unless y == vector[1]
				y += 1
			
			end
		end

	end
end

game = Game.new

game.move([4,0],[4,6])

