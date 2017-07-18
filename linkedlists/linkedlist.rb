#class to store the linked list in
class LinkedList
	attr_accessor :head, :tail

	def initialize
		@head = nil
		@tail = nil
	end

	#adds a new node to the end of the list
	def append(data)
		node = Node.new(data)
		unless empty?(data)
			@tail.next_node = node
			@tail = node
		end
	end

	#adds a new node to the beginning of the list
	def prepend(data)
		node = Node.new(data)
		unless empty?(data) 
			node.next_node = @head
			@head = node
		end
	end

	#checks if the list is currently empty, and sets the new node as the head and tail
	def empty?(data)
		node = Node.new(data)
		if @head == nil
			@head = node
			@tail = node
			true
		end
	end

	# returns number of nodes in the list
	def size
		size = 0
		if @head == nil
			size
		else	
			x = @head
			until x == nil
				size += 1
				x = x.next_node
			end
			size
		end
	end

	#returns the node at the given index
	def at(index)
		if @head == nil
			puts "No nodes in list"
		else
			x = @head
			(index).times do 
				x = x.next_node
			end
			return x
		end
	end

	# returns head value
	def head
		@head.value
	end

	# returns tail value
	def tail
		@tail.value
	end

	#removes last element in list
	def pop
		@tail = at(size-2)
		at(size-2).next_node = nil
		if size == 1
			@head = @tail
		end
	end

	#returns true if data is in the list
	def contains?(data)
		x = @head
		until x == nil
			if x.value == data
				return true
			else
				x = x.next_node
			end
		end
		return false
	end

	#returns index of node containing data, returns nil if not in list
	def find(data)
		if contains?(data)
			x = @head
			index = 0
			until x.value == data
				x = x.next_node
				index += 1
			end
			return index
		end
	end

	#represents list as a string so can be viewed in console
	def to_s
		x = @head
		until x == nil
			print "(#{x.value}) -> "
			x = x.next_node
		end
		print "nil"
	end

	#inserts node at the given index
	def insert_at(data, index)
		if index == 0
			prepend(data)
		elsif index == size
			append(data)
		else
			node = Node.new(data)
			node.next_node = at(index)
			at(index-1).next_node = node	
		end
	end

	#removes node at the given index
	def remove_at(index)
		if index == 0
			@head = @head.next_node
		elsif index == size-1
			pop
		else
			at(index-1).next_node = at(index +1)
		end
	end
end

#class for new nodes, nodes contain a value and a pointer to the next node
class Node
	attr_accessor :value, :next_node

	def initialize(data)
		@value = data
		@next_node = nil
	end
end

