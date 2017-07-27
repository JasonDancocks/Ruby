class Piece
	attr_accessor :colour, :icon 
	attr_reader :moves
end

class EmptySpace < Piece
	def initialize
		@icon = " "
	end
end

class Pawn < Piece 
	attr_reader :attack_moves, :first_moves
	attr_accessor :is_first_move

	def initialize(colour)
		@colour = colour
		@is_first_move = true
		if @colour == "white"
			@icon = "♟"
		else
			@icon = "♙"
		end
		allowed_moves
	end

	def allowed_moves
		if @colour == "white"
			@first_moves = [[0,1],[0,2]]
			@moves  = [[0,1]]
			@attack_moves = [[-1,1],[1,1]]	
		else
			@first_moves = [[0,-1],[0,-2]]
			@moves = [[0,-1]]
			@attack_moves = [[-1,-1],[1,-1]]	
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
				move = [-x,x]
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
				move = [-x,x]
				@moves << move
			end
			x += 1
		end
	end 
end