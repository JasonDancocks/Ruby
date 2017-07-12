require_relative "player"
require_relative "board"

board = Board.new
player1 = Player.new("X",0)
player2 = Player.new("O",0)
board.draw

used_positions = []

def turn(board,player,arr)
  puts "Enter position"
  input = gets.chomp
unless arr.include? (input)
  arr.push(input)
  case input
    when "1" then board.a = player.symbol
    when "2" then board.b = player.symbol
    when "3" then board.c = player.symbol
    when "4" then board.d = player.symbol
    when "5" then board.e = player.symbol
    when "6" then board.f = player.symbol
    when "7" then board.g = player.symbol
    when "8" then board.h = player.symbol
    when "9" then board.i = player.symbol
    else puts "Enter 1-9"
  end
else
  puts "Position taken, please enter new position"
  player.turncount -= 1
end
  
  board.draw
  board.check_for_win
end


until board.check_for_win 
  if player2.turncount + player1.turncount == 9
    puts "Draw!"
    break
  elsif player2.turncount < player1.turncount
     turn(board,player2,used_positions)
     player2.turncount += 1
  else
  turn(board,player1,used_positions)
  player1.turncount += 1
end

if board.check_for_win
  
  if player1.turncount > player2.turncount
    puts "Player 1 (X) has won!"
  else
    puts "Player 2 (O) has won!"
  end
end




end

