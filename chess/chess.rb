require_relative "pieces"

class Board

	Node = Struct.new(:piece)

	def initialize
		generate_board
		draw_board
	end

	def generate_board
		x = 0
		y = 0
		@node_hash ={}
		while x < 8
			while y < 8
				node = Node.new("♜")
				node.piece = EmptySpace.new
				@node_hash[([x,y])] = node
				y += 1
			end
			x += 1
			y = 0
		end
		set_pieces("white")
		set_pieces("black")	
	end

	def set_pieces(colour)
		if colour == "white"
			back = 7
			front = 6
		elsif colour == "black"
			back = 0
			front = 1
		end
		@node_hash[([0,back])].piece = Rook.new(colour)
		@node_hash[([1,back])].piece = Knight.new(colour)
		@node_hash[([2,back])].piece = Bishop.new(colour)
		@node_hash[([3,back])].piece = King.new(colour)
		@node_hash[([4,back])].piece = Queen.new(colour)
		@node_hash[([5,back])].piece = Bishop.new(colour)
		@node_hash[([6,back])].piece = Knight.new(colour)
		@node_hash[([7,back])].piece = Rook.new(colour)
		x = 0
		while x < 8
			@node_hash[([x,front])].piece = Pawn.new(colour)
			x += 1
		end
	end

	def draw_board
		puts " _______________________________ "
		y = 7
		while y >=0
			draw_row(y)
			
			if y > 0
				puts "|-------------------------------|"
			end
			y -= 1
		end
		puts " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ "
	end

	def draw_row(row)
		x = 0
		while x < 8
			print "| #{@node_hash[([x,row])].piece.icon} "
			x += 1
		end
		print "|\n"
	end
end



board = Board.new



