## Convert the string below.

munsters_description = "The Munsters are creepy in a good way."

p munsters_description.swapcase!
# => "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
p munsters_description.downcase.capitalize!
# => "The munsters are creepy in a good way."
p munsters_description.downcase!
# => "the munsters are creepy in a good way."
p munsters_description.upcase!
# => "THE MUNSTERS ARE CREEPY IN A GOOD WAY."