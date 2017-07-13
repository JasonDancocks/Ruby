require_relative "player"

def set_row
  row = []
  n = 0
  while n < 4
    puts "Enter peg #{n+1} (RBYGOP)"
    until valid_input(row,n)
    end
    n += 1
  end
  return row
end

def valid_input(arr,n)
  input = gets.chomp.downcase
  case input
  when "r" then arr[n] = "R" ; true
  when "b" then arr[n] = "B" ; true
  when "y" then arr[n] = "Y" ; true
  when "g" then arr[n] = "G" ; true
  when "o" then arr[n] = "O" ; true
  when "p" then arr[n] = "P" ; true
  else
    puts "Please enter a valid colour (RBYGOP)"
    false
  end
end


def matches(current_row,code_array)
  n = 0
  matches=[]
  while n < 4
    if current_row[n] == code_array[n]
      matches[n] = "BM"
    elsif code_array.include?(current_row[n]) 
      matches[n] = "CM"
    else 
      matches[n] = "  "
    end
    n += 1
  end
  return matches
end

def print_output(breaker,arr,f_arr)
  t = 0
  while t < breaker.turns + 1
   puts "#{arr[t]} #{f_arr[t]}"
   t += 1
  end
end


def check_for_win(breaker,arr,win)
  if(arr[0] == "BM" && arr[1] == "BM" && arr[2] == "BM" && arr[3] == "BM")
    puts "You win! You took #{breaker.turns} attempts"
    breaker.turns = breaker.max_turns
    win = true
  else
    if breaker.turns == breaker.max_turns
      puts "#{breaker.max_turns - breaker.turns} guesses remain"
      puts "Better luck next time!"
    else
      puts "#{breaker.max_turns - breaker.turns} guesses remain"
    end
  end
end

def turn(breaker,arr,f_arr, ans, win,ai)
  if ai == true
    current = breaker.set_row(f_arr,arr)
  else
    current = set_row
  end
  f_arr[breaker.turns] = matches(current,ans)
  arr[breaker.turns] = current
  print_output(breaker,arr,f_arr)
  breaker.turns += 1
  check_for_win(breaker,matches(current,ans),win)
end

def new_game
  puts "Would you like to play? Y / N"
  input = gets.chomp.downcase
  if input == "y"
    breaker = Codebreaker.new(12)
    maker = Codemaker.new
    all_guesses = []
    all_feedback = []
    win = false
    ai = false
    
    puts "Press 1 to be the Codebreaker or 2 to be the Codemaker"
    input = gets.chomp
    
    if input == "1"
      maker.random_code
      
    elsif input == "2"
      puts "Please enter code"
      input = gets.chomp
      maker.set_code(input)
      ai = true
    end
    
    until breaker.turns == breaker.max_turns
        turn(breaker,all_guesses,all_feedback,maker.code_array,win,ai)
      end
      
  elsif input == "n"
    puts "Exiting..."
    return false
  else
      new_game
  end
  new_game
end


new_game

