LANGUAGE = 'en'

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message)
  MESSAGES[LANGUAGE][message]
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def clear
  system('clear')
end

def number?(input)
  integer?(input) || float?(input)
end

def integer?(input)
  input.to_i().to_s() == input
end

def float?(input)
  /\d/.match(input) && /^-?\d*\.?\d*$/.match(input)
end

def zero?(input)
  input.to_i().to_s() != "0"
end

def what_number(number, number_message)
  loop do
    number_message
    number = Kernel.gets().chomp()

    break if number?(number)
    prompt(messages('invalid_number'))
  end

  number
end

def calculate_result(operator, first_number, second_number)
  case operator
  when '1'
    first_number.to_f + second_number.to_f
  when '2'
    first_number.to_f - second_number.to_f
  when '3'
    first_number.to_f * second_number.to_f
  when '4'
    first_number.to_f / second_number.to_f
  end
end

# Calculator starts
clear

prompt(messages('welcome'))

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(messages('valid_name'))
  else
    break
  end
end

clear

prompt(messages('greeting') + "#{name}!")

sleep 2

clear

# Main loop for calculation
loop do
  number1 = ''
  first_number = what_number(number1, prompt(messages('first_number')))

  number2 = ''
  second_number = ''
  loop do
    second_number = what_number(number2, prompt(messages('second_number')))

    break if zero?(second_number)
    prompt(messages('zero_error'))
  end

  prompt(messages('operation_options'))

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages('operation_options_error'))
    end
  end

  operation_message = case operator
                      when '1' then 'adding_operation'
                      when '2' then 'subtracting_operation'
                      when '3' then 'multiplying_operation'
                      when '4' then 'dividing_operation'
                      end

  prompt(messages(operation_message))

  sleep 2

  prompt(messages('result') + "#{calculate_result(operator, first_number, second_number)}!")

  sleep 4

  clear

  prompt(messages('question_to_perform_another_operation'))
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')

  clear
end

clear

prompt(messages('thank_you'))