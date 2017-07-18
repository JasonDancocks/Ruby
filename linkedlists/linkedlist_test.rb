def random_letter
	arr = ("a".."z").to_a.shuffle
	arr[rand(arr.size-1)]
end

def print_output
	puts list.size
	list.to_s
	puts list.head
	puts list.tail
end

def list_tester
	list = LinkedList.new
	i = 0
	while i < rand(30)
		list.append(random_letter)
		list.prepend(random_letter)
		i += 1
	end
	print_output
	j = 0
	while j < rand(5)
		list.insert_at(random_letter,rand((list.size) -1))
	end
	print_output
	k = 0
	while k < rand(5)
		x = random_letter
		y = list.find(x)
		puts "#{x} found at #{y}"
	end
	list.pop
	print_output
	list.pop
	print_output
	q = 0
	while q < 5
		x = rand((list.size)-1)
		list.remove_at(x)
		q+=1
		puts "removed at position #{x}"
	end
	print_output
end


