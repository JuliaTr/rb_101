# What is the result of the method's coll?

def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end

puts rps("rock", "paper")      
# paper
puts rps("rock", "scissors")   
# rock
puts rps(rps("rock", "paper"), rps("rock", "scissors"))    
# paper
puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")  
# paper