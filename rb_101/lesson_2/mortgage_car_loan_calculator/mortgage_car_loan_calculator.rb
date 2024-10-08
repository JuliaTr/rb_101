require 'yaml'

MESSAGES = YAML.load_file('mortgage_car_loan_calculator_messages.yml')
MONTHS_IN_YEAR = 12

def messages(message)
  MESSAGES[message]
end

def prompt(key, *args)
  message = messages(key) % args
  Kernel.puts("=> #{message}")
end

def cursor(column)
  print "\033[1A\033[#{column}C"
end

def valid_number?(input)
  valid_integer?(input) || valid_float?(input)
end

def valid_integer?(input)
  input.to_i().to_s() == input
end

def valid_float?(input)
  input.to_f().to_s() == input
end

def display_welcome_message
  system('clear')
  prompt('welcome')
  sleep 0.8
  system('clear')
end

def get_name
  name = ''
  loop do
    prompt('name')
    name = Kernel.gets().chomp().strip().upcase()
    system('clear')

    break unless name.empty?()
    prompt('invalid_name')
  end

  prompt('greeting', name)
  sleep 1
  name
end

def get_loan
  system('clear')
  loan_amount = ''
  loop do
    prompt('loan_amount', '$')
    cursor(2)
    loan_amount = Kernel.gets().chomp().delete("$").strip()
    system('clear')

    break unless loan_amount.empty?() ||
                 valid_number?(loan_amount) == false ||
                 loan_amount.to_f() <= 0
    prompt('invalid_loan_amount')
  end

  loan_amount.to_f()
end

def get_interest_rate
  interest_rate = ''
  loop do
    prompt('interest_rate', 5, 1.2, '%')
    cursor(-1)
    interest_rate = Kernel.gets().chomp().delete("%").strip()
    system('clear')

    break unless interest_rate.empty?() ||
                 valid_number?(interest_rate) == false ||
                 interest_rate.to_f() < 0
    prompt('invalid_interest_rate')
  end

  interest_rate
end

def get_loan_duration
  loan_duration_in_years = ''
  loop do
    prompt('loan_duration_in_years')
    loan_duration_in_years = Kernel.gets().chomp().strip()
    system('clear')

    break unless loan_duration_in_years.empty?() ||
                 valid_number?(loan_duration_in_years) == false ||
                 loan_duration_in_years.to_f() <= 0
    prompt('invalid_loan_duration_in_years')
  end

  loan_duration_in_years.to_f()
end

def calculate_interest_rate(annual_interest_rate)
  if annual_interest_rate == "0"
    converted_0_interest_rate = annual_interest_rate.to_i()
  else
    converted_interest_rate = annual_interest_rate.to_f()
    interest_rate_in_percentage = converted_interest_rate / 100
    monthly_interest_rate_in_percentage = interest_rate_in_percentage /
                                          MONTHS_IN_YEAR
  end

  return converted_0_interest_rate, monthly_interest_rate_in_percentage
end

def calculate_loan_duration(loan_duration_in_years)
  loan_duration_in_years * MONTHS_IN_YEAR
end

def calculate_monthly_payment(loan, monthly_interest_rate,
                              loan_duration_in_months)
  if monthly_interest_rate[0] == 0
    monthly_payment_0_interest_rate = loan / loan_duration_in_months
  else
    monthly_payment = loan * (monthly_interest_rate[1] / (1 -
    ((1 + monthly_interest_rate[1])**(-loan_duration_in_months))))
  end

  return monthly_payment_0_interest_rate, monthly_payment
end

def display_summary(loan, monthly_interest_rate, loan_duration_in_months)
  if monthly_interest_rate[0]
    prompt('summary', '$', loan, monthly_interest_rate[0],
           loan_duration_in_months)
  else
    prompt('summary', '$', loan, monthly_interest_rate[1],
           loan_duration_in_months)
  end
end

def display_continue_calculation
  prompt('continue_calculation')
  answer_for_calculation = Kernel.gets().chomp()

  if answer_for_calculation.downcase().start_with?('y') ||
     answer_for_calculation == ""
    prompt('calculation')
    sleep 1
  end
end

def display_monthly_payment(monthly_payment)
  if monthly_payment[0]
    prompt('your_monthly_payment', '$', monthly_payment[0])
  else
    prompt('your_monthly_payment', '$', monthly_payment[1])
  end
end

def display_another_calculation
  prompt('question_to_perform_another_calculation')
  answer = Kernel.gets().chomp()
  system('clear')
  answer.downcase().start_with?('y') || answer == ""
end

display_welcome_message()
name = get_name()

loop do
  loan = get_loan()
  annual_interest_rate = get_interest_rate()
  loan_duration_in_years = get_loan_duration()

  monthly_interest_rate = calculate_interest_rate(annual_interest_rate)
  loan_duration_in_months = calculate_loan_duration(loan_duration_in_years)
  monthly_payment = calculate_monthly_payment(loan, monthly_interest_rate,
                                              loan_duration_in_months)

  display_summary(loan, monthly_interest_rate, loan_duration_in_months)
  display_continue_calculation()
  display_monthly_payment(monthly_payment)
  break unless display_another_calculation()
end

prompt('thank_you', name)
