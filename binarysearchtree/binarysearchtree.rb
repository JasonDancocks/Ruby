class Node
	attr_accessor :array, :value, :parent, :left_child, :right_child, :root, :first

	def initialize(data)
		@value = data
		@parent, @left_child, @right_child, @root = nil
		@first = true
	end

	def build_tree(arr)
		tree_array = []
		arr.each do |x|
			node = Node.new(x)
			if first
				@first = false
				@root = node
			else
				add_node(node,@root)
			end
			tree_array << node
		end

		tree_array
	end

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
			current.value = [current.value]
			current.value << node.value

		elsif x == 1
			if current.right_child.nil?
				current.right_child = node
				node.parent = current
			else
				add_node(node,current.right_child)
			end
		end


		def check_parent
			unless @root
				unless @parent.nil?
					return @parent.value
				end
				return false
			end
		end

		def check_left
			unless @left_child.nil?
				return @left_child.value
			end
		end
	end

	def check_right
		unless @right_child.nil?
			return @right_child.value
		end
	end
end






def test_build_tree
	arr = []

	20.times do
		arr << rand(50)
	end

	tree_array = Node.new(arr).build_tree(arr)


	i = 0
	tree_array.each do |x|
		if i ==0
			puts " <left = #{x.check_left}>					<#{x.value}>	<parent = #{x.check_parent}>					<right = #{x.check_right}>"
			i +=1
		else
			unless x.parent.nil? 
				puts " <left = #{x.check_left}>					<#{x.value}>	<parent = #{x.check_parent}>					<right = #{x.check_right}>"
			end
		end
	end
end

test_build_tree