def merge_sort(arr)
	n = arr.length
	# if array is less than 2 (1 element or 0 elements) it is sorted already
	if n < 2
		return arr
	end
	#splits array into two arrays and recursively calls merge_sort on both
	left_arr = merge_sort(arr[0..((n/2)-1)])
	right_arr = merge_sort(arr[(n/2)..n])
	#result array
	sorted_arr = []	
	#runs until all elements shifted from one half to the result
	until left_arr.length <1 || right_arr.length <1
		# compares first number in both and moves smaller to result
		if  left_arr[0] < right_arr[0]
			sorted_arr << left_arr.shift
		else
			sorted_arr << right_arr.shift	
		end
		
	end
	# adds on any left over numbers in either array
	return sorted_arr + left_arr + right_arr
end

arr = [5,3,7,8,5,33,2,1,5,6]

p merge_sort(arr)