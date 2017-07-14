require_relative "player"
class Mastermind
  attr_accessor :breaker, :maker
  # creates new instance and starts game
  def initialize
    puts "Welcome to Mastermind!" 
    start
  end
  
  #starts new game process, allows user to exit
  def start
    puts "Press Y to play or N to exit"
    input = gets.chomp.downcase
      if input == "y"
        new_game
      elsif input == "n"
        puts "Exiting..."
      else
        start
      end
  end
  
  #choose to which player to be and calls the codemaker to set the code.
  def choose_role
    puts "Press 1 to be the Codebreaker or 2 to be the Codemaker"
    input = gets.chomp
    if input == "1"
      @maker.random_code
    elsif input == "2"
      @maker.set_code
      @breaker.ai = true
    else
      choose_role
    end
  end
  
  #starts a new game, initializes both players and loops the turns.
  def new_game
    @breaker = Codebreaker.new
    @maker = Codemaker.new
    choose_role
    until @breaker.turns >= @breaker.max_turns
      @breaker.turn(@maker.code)
      @breaker.turns
    end
    puts "Play again?"
    start
  end
end

Mastermind.new