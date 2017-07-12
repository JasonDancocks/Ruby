require_relative "board"
require_relative "player"


player = Codebreaker.new(12)

ai = Codemaker.new

ai.random_code
win = false
all_guesses = []
all_feedback = []


def turn(player,arr,f_arr, ans, win, n = 0)
  current_row = []
  while n < 4
    puts "Enter peg #{n+1} (RBYGOP)"
    until valid_input(current_row,n)
    end
    n += 1
  end
  fb =  matches(current_row,ans)
  f_arr[player.turns] = fb
  arr[player.turns] = current_row
  t = 0
  while t < player.turns + 1
   puts "#{arr[t]} #{f_arr[t]}"
   t += 1
  end
 
  player.turns += 1
  check_for_win(player,fb,ans,win)
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

def check_for_win(player,arr,ans,win)
 
    if(arr[0] == "BM" && arr[1] == "BM" && arr[2] == "BM" && arr[3] == "BM")
      puts "You win! You took #{player.turns} attempts"
      player.turns = player.max_turns
      win = true
     else
       if player.turns == player.max_turns
         puts "#{player.max_turns - player.turns} guesses remain"
         puts "Better luck next time!"
       else
         puts "#{player.max_turns - player.turns} guesses remain"
       end
    end
  end

  



until player.turns == player.max_turns
  turn(player,all_guesses,all_feedback,ai.code_array,win)
  
end

