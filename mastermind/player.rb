class Codebreaker
 attr_accessor :max_turns, :turns
  
  def initialize(max_turns, turns = 0)
    @max_turns = max_turns
    @turns = turns
  end
  
  def set_row(f_arr,arr,allowed_colours = ["R","B","Y","G","O","P"])
    row = []
    n = 0
     while n < 4
        if @turns > 0
          if f_arr[@turns -1][n] =="BM"
            row.push(arr[@turns-1][n])
          else
            row.push(allowed_colours[rand(5)])
          end
        else
          row.push(allowed_colours[rand(5)])
        end
        n += 1
      end
    return row
  end
  
end


class Codemaker
  attr_accessor :code, :code_array
  allowed_colours = ["R","B","Y","G","O","P"]
  
  def set_code(string)
    @code_array = string.upcase.split("")
  end
  
  def random_code(allowed_colours = ["R","B","Y","G","O","P"])
    n = 0
    @code_array = ""
    while n < 4
      @code_array += allowed_colours[rand(5)]
      n += 1
    end
    return @code_array
  end
    
end