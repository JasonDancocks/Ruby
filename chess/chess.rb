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
				@node_hash[([x,y])] = node
				y += 1
			end
			x += 1
			y = 0
		end
		

	end

	def draw_board
		puts " _______________________________ "
		y = 0
		while y < 8
			draw_row(y)
			
			if y < 7
				puts "|-------------------------------|"
			end
			y += 1
		end
		puts " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ "
	end


	def draw_board_static

		puts " _______________________________ "
		puts "| ♜	| ♞ |	♝ |	♛ |	♚ |	♝ |	♞ |	♜ |"
		puts "|-------------------------------|"
		puts "| ♟ |	♟ |	♟ |	♟ |	♟ |	♟ |	♟ |	♟ |"
		puts "|-------------------------------|"
		puts "|   |   |   |   |   |   |   |   |"
		puts "|-------------------------------|"
		puts "|   |   |   |   |   |   |   |   |"
		puts "|-------------------------------|"
		puts "|   |   |   |   |   |   |   |   |"
		puts "|-------------------------------|"
		puts "|   |   |   |   |   |   |   |   |"
		puts "|-------------------------------|"
		puts "| ♙ |	♙ |	♙ |	♙ |	♙ |	♙ |	♙ |	♙ |"
		puts "|-------------------------------|"
		puts "| ♖ |	♘ |	♗ |	♕ |	♔ |	♗ |	♘ |	♖ |"
		puts " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ "
		
	end

	def draw_row(row)
		x = 0
		while x < 8
			print "| #{@node_hash[([x,row])].piece} "
			x += 1
		end
		print "|\n"
	end

end

board = Board.new



