#Warmup: Fibonacci
#The Fibonacci Sequence, which sums each number with the one before it, is a great example of a problem that can be solved recursively.

#Your Task
#Write a method #fibs which takes a number and returns that many members of the fibonacci sequence. Use iteration for this solution.
#Now write another method #fibs_rec which solves the same problem recursively. This can be done in just 3 lines (or 1 if you're crazy, but don't consider either of these lengths a requirement... just get it done).

def fibs_rec(n)
  if n == 1
     [0]
  elsif n == 2
     [0,1]
  else
    fibs_rec(n-1) << fibs_rec(n-1)[-1]  + fibs_rec(n-1)[-2]
  end
end


def fibs(n)
  i = 2
  num = [0,1]
  if n == 1
    num = [0]
  elsif n == 2
    num = [0,1]
  else
    while i < n
     num << num[i-1] + num[i-2]
     i+= 1
   end
 end
 return num
end

n = 10



puts"#{fibs(n)} fibs || #{fibs_rec(n)} fibs_rec"