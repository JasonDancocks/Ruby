require_relative "pieces"
require_relative "board"

class Game
	attr_accessor :board

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

	def check_collision(start, vector)		
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
				unless @board.node_hash[(check)].piece.is_a?(EmptySpace)
					puts "Path blocked by #{@board.node_hash[(check)].piece.icon} at (#{check})"
					return false
				end
			end
		end
		return true
	end

end

game = Game.new

game.move([3,1],[3,2])
game.move([4,0],[0,4])

