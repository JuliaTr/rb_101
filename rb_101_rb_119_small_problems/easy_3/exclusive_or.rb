=begin

PROBLEM
In this exercise, you will write a method named `xor` that takes two 
arguments, and returns `true` if exactly one of its arguments is truthy,
`false` otherwise. Note that we are looking for a boolean result instead
of a truthy/falsy value as returned by `||` and `&&`.

TEST CASES
p xor?(5.even?, 4.even?) == true
p xor?(5.odd?, 4.odd?) == true
p xor?(5.odd?, 4.even?) == false
p xor?(5.even?, 4.odd?) == false
p xor?('abc', nil) == true
p xor?(nil, 'abc') == true
p xor?('abc', 'abc') == false
p xor?(nil, nil) == false

________________________________________________________________________

PEDAC

Problem:
  - Input: Two objects (integer / string / `nil` / boolean).
  - Output: A boolean value.

  - Rules:
    - Explicit: 
      - Write a method named `xor` that takes two arguments, and 
        returns `true` if exactly one of its arguments is truthy,
        `false` otherwise.
      - Look for a boolean result instead of a truthy/falsy value as 
        returned by `||` and `&&`.
    - Implicit:
      - (?)

Examples and Test Cases:
  - All test cases conform to the rules.

Data Structure:
  - Work with strings, integers, booleans.

Algorithm:
  - Define a method called `xor` which takes two parameters.
  - If only one of the arguments truthy, return `true`.
  - If not, return `false`.
=end

def xor?(arg1, arg2)
  if ((arg1 == true) && (arg2 == true)) ||
    ((arg1 == false) && (arg2 == false)) ||
    (arg1 && arg2) || (!arg1 && !arg2)
    false
  else
    true
  end
end

p xor?(5.even?, 4.even?) == true  # true  # false || true == true
p xor?(5.odd?, 4.odd?) == true    # true  # true || false == true
p xor?(5.odd?, 4.even?) == false  # true  # true || true == false
p xor?(5.even?, 4.odd?) == false  # true  # false || false == false
p xor?('abc', nil) == true        # true  # truthy || falsey == true
p xor?(nil, 'abc') == true        # true  # falsey || truthy == true
p xor?('abc', 'abc') == false     # true  # truthy || truthy == false
p xor?(nil, nil) == false         # true  # falsey || falsey == false



## Experiments:
def xor?(arg1, arg2)
  if arg1 ^ arg2
    true
  else
    false
  end
end

p xor?(5.even?, 4.even?) == true  # true
p xor?(5.odd?, 4.odd?) == true    # true
p xor?(5.odd?, 4.even?) == false  # true
p xor?(5.even?, 4.odd?) == false  # true
# p xor?('abc', nil) == true      # false     
p xor?(nil, 'abc') == true        # true
# p xor?('abc', 'abc') == false   # false
p xor?(nil, nil) == false         # true



## Further exploration
=begin
Does the `xor` method perform short-circuit evaluation of its operands? 
Why or why not? Does short-circuit evaluation in xor operations even make 
sense?

There are `&&` and `||` operators in the method `xor` body. These operator short-circuit if
the first operand of `&&` operator is a falsy value, if the first operand of `||` operator 
is a truthy value.
In the solution above on lines 50 through 52 the short-circuiting happens when:
on lines 50 and 51, the first operands of `((arg1 == true) && (arg2 == true))`, 
`((arg1 == false) && (arg2 == false))`, `(arg1 && arg2)`, `(!arg1 && !arg2)` 
expressions evaluate to false.

Also, when Ruby encounters the first truthy value in the expression
with `||` operator, the short-circuiting happens.
=end

