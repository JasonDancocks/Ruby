class KnightsTravails

	attr_accessor :knight_moves

	Node = Struct.new(:position, :parent)

	def initialize
		@knight_moves = [[2,1],[2,-1],[1,2],[1,-2],[-1,2],[-1,-2],[-2,1],[-2,-1]]
	end

	def knight_move(start,finish)
		if start.any? {|x| x > 7 || x < 0} || finish.any?{|y| y > 7 || y < 0}
			puts "Invalid position"
		else
			move = bfs(start,finish)
			count = 0
			path = ""
			move.each do |x|
				path += "#{x}\n"
				count += 1
			end
			puts "You made it in #{count} moves! Here's your path:"
			puts "#{start}"
			puts "#{path}"
		end
	end

	def bfs(start,finish)
		queue = []
		node = Node.new(start,nil)
		queue << node
		until queue.length < 1 
			if node.position == finish
				return get_path(node)
			end
			children = get_children(node)
			children.each {|x| queue << x}
			node = queue.shift
		end
	end

	def get_children(parent)
		children = []
		next_position = get_next_position(parent.position)
		next_position.each {|position| children << Node.new(position,parent)}
		children
	end

	def get_path(node)
		path = []
		until node.parent.nil?
			path.unshift(node.position)
			node = node.parent
		end
		path
	end

	def get_next_position(position)
		destinations = []
		@knight_moves.each do |x|
			new_position = [position[0] + x[0], position[1] + x[1]]
			unless new_position.any? {|z| z > 7 || z < 0}
				destinations << new_position
			end
		end
		destinations
	end
end



testa = KnightsTravails.new

testa.knight_move([1,1],[7,3])