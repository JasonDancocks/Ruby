class Piece
	attr_accessor :colour, :icon
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
	end
end 