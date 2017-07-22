#class with attributes for each node
class Node
	attr_accessor :value, :parent, :left_child, :right_child, 

	#initializes new nodes with nil values
	def initialize
		@value, @parent, @left_child, @right_child = nil
	end
	
	#checks if the node has a parent and returns its value if it does
	def check_parent
		unless @root
			unless @parent.nil?
				return @parent.value
			end
			return false
		end
	end

	#checks if the node has a left child and returns its value if it does
	def check_left
		unless @left_child.nil?
			return @left_child.value
		end
	end

	#checks if the node has a right child and returns its value if it does
	def check_right
		unless @right_child.nil?
			return @right_child.value
		end
	end
end

#class to contain the tree itself
class BinarySearchTree
	attr_accessor :root, :tree_array

	#runs buld tree as soon as a tree is created.
	def initialize(arr)
		@root = nil
		build_tree(arr)
	end

	#builds the tree. tree array is there to aid printing out the array to make sure the tree has been constructed correctly, will work without.
	def build_tree(arr)
		@tree_array = []
		arr.each do |x|
			node = Node.new
			node.value = x
			if @root.nil?
				@root = node
			else
				add_node(node,@root)
			end
			@tree_array << node
		end
	end
	#adds a node to the tree, creates an array at the node if there is a duplicate value
	def add_node(node,current)
		if current.value.is_a? (Array)
			x = node.value <=> current.value[0]
		else
			x = node.value <=> current.value
		end
		if x == -1 
			if current.left_child.nil?
				current.left_child = node
				node.parent = current
			else
				add_node(node,current.left_child)
			end
		elsif x == 0
			if current.value.is_a?(Array)
				current.value << node.value
			else
				current.value = [current.value]
				current.value << node.value
			end		
		elsif x == 1
			if current.right_child.nil?
				current.right_child = node
				node.parent = current
			else
				add_node(node,current.right_child)
			end
		end
	end

	# does a breadth first seach by first creating an array to act as a queue for each value in the tree, then checking each value
	def breadth_first_search(value)
		node_queue = [@root]
		value_found = false
		location = nil
		get_node_queue(@root,node_queue)
		node_queue.each do |x|
			if x.value.is_a?(Array)
				if x.value[0] == value
					value_found = true
					location = x
					break
				end
			else
				if x.value == value
					value_found = true
					location = x
					break
				end
			end
		end
		if value_found == true
			puts "#{value} was found in the tree at #{location} "
		else
			puts "#{value} was not found in the tree"
		end
	end

	#creates the queue by reading each nodes children if the exist, root is added before method ran so all nodes picked up using method recursively
	def get_node_queue(node,arr)
		unless node.nil?

			if node.check_left
				arr<< node
			end
			if node.check_right
				arr << node
			end
			unless node.left_child.nil?
				get_node_queue(node.left_child,arr)
			end
			unless node.right_child.nil?
				get_node_queue(node.right_child,arr)
			end
		end
	end

	#depth first search , using an array as a stack. builds the stack in a similar manner to the above search, but reads last value and pops to loop.
	def depth_first_search(value)
		node_stack = []
		value_found = false
		location = nil
		get_node_stack(@root,node_stack)
		node_stack_values = []
		node_stack.each do |x|
			node_stack_values << x.value
		end
		p node_stack_values
		until node_stack.length == 0
			x = node_stack[-1]
			puts "Checking (#{x.value}"
			if x.value.is_a?(Array)
				if x.value[0] == value
					value_found = true
					location = x
					break
				end
			else
				if x.value == value
					value_found = true
					location = x
					break
				end
			end
			node_stack.pop()
		end
		if value_found == true
			puts "#{value} was found in the tree at #{location} "
		else
			puts "#{value} was not found in the tree"
		end
	end

	#builds stack array recursively by checking child nodes and reading the left then data then right.
	def get_node_stack(node,arr)
		unless node.nil?
			if node.check_left
				get_node_stack(node.left_child,arr)
			end
			arr << node
			if node.check_right
				get_node_stack(node.right_child,arr)
			end

		end
	end

	#recursive depth first search, checks left, then data then right
	def dfs_rec(value, node)
		unless node.nil?
			if node.check_left
				dfs_rec(value,node.left_child)
			end
			if node.value.is_a?(Array)
				if node.value[0] == value
					puts "#{value} was found at #{node}"
				elsif node.value == value
					puts "#{value} was found at #{node}"
				end
			end
			if node.check_right
				dfs_rec(value,node.right_child)
			end
		end
	end
end


#method to test, creates a random array builds a new search tree. tree_array methods are there just to help visualise, not required
def test_build_tree
	arr = []
	20.times do
		arr << rand(50)
	end
	tree = BinarySearchTree.new(arr)
	#just for visualisation
	tree_array = tree.tree_array
	puts tree_array[0].left_child
	i = 0
	tree_array.each do |x|
		if i ==0
			puts " <left = #{x.check_left}><value = #{x.value}>	<parent = #{x.check_parent}><right = #{x.check_right}>"
			i +=1
		else
			unless x.parent.nil? 
				puts " <left = #{x.check_left}>					<#{x.value}>	<parent = #{x.check_parent}>					<right = #{x.check_right}>"
			end
		end
	end
	value = rand(50)
	unless tree.dfs_rec(value,tree.root)
		puts "#{value} not found"
	end
	
end

test_build_tree