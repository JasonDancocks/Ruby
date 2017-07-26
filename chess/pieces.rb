class Piece
	attr_accessor :colour, :icon, :moves
end

class EmptySpace < Piece
	def initialize
		@icon = " "
	end
end

class Pawn < Piece 

	def initialize(colour)
		@colour = colour
		if @colour == "white"
			@icon = "♟"
		else
			@icon = "♙"
		end
		allowed_moves
	end

	def allowed_moves
		@moves  = [0,1]	
	end
end

class Rook < Piece

	def initialize(colour)
		@colour = colour
		if @colour =="white"
			@icon = "♜"
		else
			@icon = "♖"
		end

		allowed_moves
	end

	def allowed_moves
		@moves =[]
		x = -7
		while x < 8
			if x != 0
				move = [0,x]
				@moves << move
				move = [x,0]
				@moves << move
			end
			x += 1
		end
		@moves.sort!
	end
end

class Bishop < Piece

	def initialize(colour)
		@colour = colour
		if @colour =="white"
			@icon = "♝"
		else
			@icon = "♗"
		end

		allowed_moves
	end

	def allowed_moves
		@moves = []
		x = -7
		while x < 8
			if x != 0
				move = [x,x]
				@moves << move
			end
			x += 1
		end
	end
end

class Knight < Piece

	def initialize(colour)
		@colour = colour
		if @colour =="white"
			@icon = "♞"
		else
			@icon = "♘"
		end
		@moves = [[2,1],[2,-1],[1,2],[1,-2],[-1,2],[-1,-2],[-2,1],[-2,-1]]
	end
end

class King < Piece
	def initialize(colour)
		@colour = colour
		if @colour =="white"
			@icon = "♛"
		else
			@icon = "♕"
		end
		@moves = [[-1,0],[0,1],[1,0],[0,-1]]
	end
end

class Queen < Piece
	def initialize(colour)
		@colour = colour
		if @colour =="white"
			@icon = "♚"
		else
			@icon = "♔"
		end
		allowed_moves
	end

	def allowed_moves
		@moves = []
		x = -7
		while x < 8
			if x != 0
				move = [x,x]
				@moves << move
				move = [0,x]
				@moves << move
				move = [x,0]
				@moves << move
			end
			x += 1
		end
		@moves.sort!
	end 
end