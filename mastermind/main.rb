require_relative "player"


def new_game
  puts "Would you like to play? Y / N"
  input = gets.chomp.downcase
  if input == "y"
    breaker = Codebreaker.new
    maker = Codemaker.new
  
    puts "Press 1 to be the Codebreaker or 2 to be the Codemaker"
    input = gets.chomp
    
    if input == "1"
      maker.random_code
      
    elsif input == "2"
      puts "Please enter code"
      maker.set_code
      breaker.ai = true
    else
    end
    
    until breaker.turns >= breaker.max_turns
        breaker.turn(maker.code)
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

