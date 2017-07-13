class Codebreaker
 attr_accessor :turns, :code_array, :fb_array, :ai
 attr_reader :max_turns, :allowed_colours
  
  def initialize
    @max_turns = 12
    @turns = 0
    @allowed_colours = ["R","B","Y","G","O","P"]
    @code_array = []
    @fb_array = []
    @ai = false
    
  end 
  
  def set_row(ans)
    puts "Enter row #{@turns +1} (RGYBOP) "
    input= gets.chomp.upcase
    until valid_input(input)
      input = gets.chomp.upcase
    end
    input = input.split("")
    save_rows(input,ans)
  end
  
  def set_row_ai(ans)
    row = []
    n = 0
     while n < 4
        if @turns > 0
          if @fb_array[@turns -1][n] =="BM"
            row.push(@code_array[@turns-1][n])
          else
            row.push(@allowed_colours[rand(5)])
          end
        else
          row.push (@allowed_colours[rand(5)])
        end
        n += 1
      end
    save_rows(row,ans)
  end
  
  def valid_input(input)
    n = 0
    if input.length == 4
      while n < 4
        unless @allowed_colours.include?(input[n])
          puts "Please enter a valid colour (RBYGOP)"
          return false
        end
        n+= 1
      end
    else
      puts "Please enter four colours (RBYGOP)"
      return false
    end
    return true
  end
  
  def save_rows(row,ans)
    @code_array.push(row)
    @fb_array.push(matches(row,ans))
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
    
  def print_output
    t = 0
    while t < @turns + 1
      puts "#{@code_array[t]} #{@fb_array[t]}"
      t += 1
    end
  end
  
  def check_for_win
    if @fb_array[@turns-1].all? {|x| x =="BM"}
      puts "You win! You took #{@turns} attempts"
      @turns = @max_turns
    else
      if @turns  == @max_turns
        puts "#{@max_turns - @turns } guesses remain"
        puts "Better luck next time!"
      else
        puts "#{@max_turns - @turns  } guesses remain"
      end
    end
  end

  def turn(ans)
    if @ai == true
      set_row_ai(ans)
    else
      set_row(ans)
    end
    print_output
    @turns += 1
    check_for_win
  end
end

class Codemaker
  
  attr_reader:code, :allowed_colours
  
  def initialize
   @allowed_colours = ["R","B","Y","G","O","P"]
  end
  
  def set_code
    @code = gets.chomp.upcase.split("")
  end
  
  def random_code
    n = 0
    @code = ""
    while n < 4
      @code += @allowed_colours[rand(5)]
      n += 1
    end
    return @code
  end
    
end