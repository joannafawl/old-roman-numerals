$CONVERSIONS = {
  "M" => 1000,
  "CM" => 900,
  "D" => 500,
  "CD" => 400,
  "C" => 100,
  "XC" => 90,
  "L" => 50,
  "XL" => 40,
  "X" => 10,
  "IX" => 9,
  "V" => 5,
  "IV" => 4,
  "I" => 1
}

def decoder(roman)
  new_roman = roman.clone  
  result = 0
    $CONVERSIONS.each do |letter, num|
      while new_roman.start_with?(letter)
        result += num
        new_roman.sub!(letter, "")
      end 
    end
  if new_roman.length == 0
    return result
  else
    return nil
  end
end

def encoder(number)
  if number > 3999 or number <= 0
    return nil
  else
    new_number = number.clone
    result = ""
    $CONVERSIONS.each do |roman, num|
      quotient, remainder = new_number.divmod(num)
      if quotient > 0
        result << roman * quotient
        new_number = remainder
      end
    end
    return result
  end
end

def display_info
  puts "\n  According to Wikipedia, Roman numerals are a numeral system that originated in ancient Rome. They were the main way of writing numbers until the Late Middle Ages, when they were replaced by Arabic numerals.
    
  Numbers are represented by combinations of letters from the Latin alphabet. For example, 11 is written as 'XI', meaning 'ten plus one', whereas 4 is written as 'IV', meaning 'one less than five'. The largest number that can be written this way is 3999.
    
  The current year, 2020, is written 'MMXX' in Roman numerals.
    
  Here is a handy chart of each Roman numeral and its value:\n\n"

  $CONVERSIONS.each { |key, value|
    puts "\t#{key}: #{value}"
  } 
end

def converter
  repeating = true
  while repeating
    puts "\nEnter either a number or a Roman numeral to convert."
    input = gets.chomp
    begin
      input = Integer(input)
      if encoder(input) != nil
        puts "#{input} converted to Roman numerals is #{encoder(input)}."
      else
        puts "Please ensure number is between 1 and 3999."
        next
      end
    rescue ArgumentError
      input.upcase!
      if decoder(input) != nil
        puts "#{input} converted from Roman numerals is #{decoder(input)}."
      else
        puts "Invalid Roman numeral. Try again."
        next
      end
    end
    puts "Would you like to convert something else? (yes/no)"
    response = gets.chomp.strip.downcase
    until ["yes", "y", "no", "n", "q"].include?(response)
      puts "Please enter either yes or no."
      response = gets.chomp
    end
    if ["no", "n", "q"].include?(response)
      repeating = false
    else
      next
    end
  end
end

def practice_questions
  repeating = true
    while repeating 
      random_number = rand(1..3999)
      tries = 0
      puts "\nWhat is #{random_number} written in Roman numerals?"
      while tries < 3
        input = gets.chomp.upcase
        if input == encoder(random_number) 
          puts "Correct! You really know your Roman numerals."
          break
        elsif tries == 2
          puts "That's incorrect. The correct answer was #{encoder(random_number)}. You might need to do a little more revision on Roman numerals."
          break
        else
          puts "Not quite! Try again."
          tries += 1
        end
      end
      puts "Would you like to practice again? (yes/no)"
      response = gets.chomp.strip.downcase
      until ["yes", "y", "no", "n", "q"].include?(response)
          puts "Please enter either yes or no."
          response = gets.chomp
      end
      if ["no", "n", "q"].include?(response)
        repeating = false
      else
        next
      end
    end
end

class Question
  attr_reader :prompt, :answer
  def initialize(prompt, answer)
    @prompt = prompt
    @answer = answer
  end
end

q1 = "\n1. What is CMXCIX in Arabic numerals?\n(a) 999\n(b) 1009\n(c) 990"
q2 = "\n2. What is 137 in Roman numerals?\n(a) CXXLVII\n(b) CXXXVII\n(c) CXIIIL"
q3 = "\n3. What is CCXLV + LXVII?\n(a) CCCXIV\n(b) CCCXII\n(c) CCCIV"
q4 = "\n4. What is CCLVI / 8?\n(a) XLIV\n(b) XXXVI\n(c) XXXII"
q5 = "\n5. What is 23 * 41?\n(a) CMXLIII\n(b) CMII\n(c) CMLXVI"

questions = [
  Question.new(q1, "a"),
  Question.new(q2, "b"),
  Question.new(q3, "b"),
  Question.new(q4, "c"),
  Question.new(q5, "a")
]

def run_test(questions)
  score = 0
  for question in questions
    puts question.prompt
    user_answer = gets.chomp
    if user_answer.downcase == question.answer
      score += 1
    end
  end
  if score >= 4
    puts "Great job! You got #{score} out of #{questions.length} correct."
  elsif score >= 2
    puts "Not bad! You got #{score} out of #{questions.length} correct."
  else
    puts "Good try. You got #{score} out of #{questions.length} correct."
  end
end

def quit_application
  puts "Thank you for using the Roman Numeral Converter! We hope you learnt something new!"
end

puts "Welcome to the Roman Numeral Converter!"

running = true

while running
  
  puts "\nWhat would you like to do?
\n  1) Learn more about Roman numerals 
  2) Use the converter
  3) Practice conversion skills
  4) Take the test
  5) Quit
  
Please enter an option from 1-5."

  choice = gets.chomp

  case choice
  
  when "1" then display_info
  when "2" then converter
  when "3" then practice_questions
  when "4" then run_test(questions)
  when "5", "q"
    quit_application
    running = false
  else
    puts "Invalid choice. Please enter a number from 1-5."
  end
end
