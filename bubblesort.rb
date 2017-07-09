test_arr = [7,6,5,4,3,2,1]
test_arr_strings = ["hi","hello","hey", "hoy", "ho","howdy","hey there","greetings"]

def bubble_sort (arr)
	n = arr.length
	swapped = true
	until swapped == false
		i = 1 
		swapped = false
		while i < n 
			if (arr[i-1] > arr[i])
				arr[i-1], arr[i ] = arr[i], arr[i-1]
				swapped = true
			end	
			i+=1
		end
		n -= 1
	end
	return arr
end

def bubble_sort_by(arr)
	n = arr.length
	swapped = true
	until swapped == false
		i = 1 
		swapped = false
		while i < n 
			result = yield arr[i-1], arr[i]
			if (result > 0)
				arr[i-1], arr[i ] = arr[i], arr[i-1]
				swapped = true
			end	
			i+=1
		end
		n -= 1
	end
	return arr
end



p bubble_sort(test_arr)

p bubble_sort_by(test_arr_strings) {|left,right| left.length - right.length}
