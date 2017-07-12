class Board
  
  attr_accessor :a, :b, :c, :d, :e, :f, :g, :h, :i, :win
  
	def initialize(a=1,b=2,c=3,d=4,e=5,f=6,g=7,h=8,i=9, win = false)
		@a = a
		@b = b
		@c = c
		@d = d
		@e = e
		@f = f
		@g = g
		@h = h
		@i = i
		@win = win
	end

	def draw
		puts " #{@a} | #{@b} | #{@c} "
		puts "***********"
		puts " #{@d} | #{@e} | #{@f} "
		puts "***********"
		puts " #{@g} | #{@h} | #{@i} "
	end
	
	def check_for_win
    win = false
  if (@a == @b && @a == @c)
    win = true
  elsif (@d == @e && @d == @f)
    win = true
  elsif (@g == @h && @h == @i)
    win = true
  elsif (@a == @d && @a == @g)
    win = true
  elsif (@b == @e && @b == @h)
    win = true
  elsif (@c == @f && @c == @i)
    win = true
  elsif (@a == @e && @a == @i)
    win = true
  elsif (@c == @e && @c == @g)
    win = true
  else
    win = false
  end
  return win
end
end