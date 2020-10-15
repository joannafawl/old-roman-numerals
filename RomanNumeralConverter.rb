=begin
A Roman Numeral Converter that aims to teach the user about what a Roman numeral is, converts between Roman numerals and Arabic numbers and allows the user to practice on randomly generated numbers and to take a short test on them.
=end

=begin 
A hash with Roman numerals and corresponding values. We use a constant with public scope so that it can be used in multiple functions throughout the program.
=end 
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

=begin
The decoder function takes a Roman numeral as an input which is cloned so that we have a copy of the original input. For each letter in the conversion chart, if the numeral starts with that letter then we add its corresponding value to the total. Then we remove the letter and check if the next letter is in the hash.

If the length of the Roman numeral string is not 0, it must contain a character that is not in the hash. This means it is an invalid input, so we return nil.
=end
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

=begin
The encoder function takes a number as an argument which is cloned so we have a copy of the original input. If the number is between 1 and 3999 inclusive, then for each number in the conversion chart, we divide the input by it to get a quotient and remainder. We add the corresponding Roman numeral to the result 'quotient' times and continue the algorithm with the remainder. 
=end
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

=begin
A small information section on what Roman numerals are. Each Roman numeral is displayed with its value so that it can be referred back to when doing a practice exercise.
=end
def display_info
  puts "\n  According to Wikipedia, Roman numerals are a numeral system that originated in ancient Rome. They were the main way of writing numbers until the Late Middle Ages, when they were replaced by Arabic numerals.
    
  Numbers are represented by combinations of letters from the Latin alphabet. For example, 11 is written as 'XI', meaning 'ten plus one', whereas 4 is written as 'IV', meaning 'one less than five'. The largest number that can be written this way is 3999.
    
  The current year, 2020, is written 'MMXX' in Roman numerals.
    
  Here is a handy chart of each Roman numeral and its value:\n\n"

  $CONVERSIONS.each { |key, value|
    puts "\t#{key}: #{value}"
  } 
end

=begin
The converter asks for a user input of either a number or a Roman numeral. If the input can be converted to an integer using Integer, we know that the user entered a number to convert into a Roman numeral so we use the encoder function and print out the converted numeral. If the encoder function returns nil, it must not be an integer between 1 and 3999 so we print this to tell the user.

If the input cannot be converted to an integer, it must be a string so the user entered a Roman numeral. Here, we use a rescue block which catches the argument error and continues the conversion from a Roman numeral to an Arabic numeral. If the input contains characters in the string which are not Roman numerals, the function returns nil so we know that the input is invalid and can be entered again.

The function repeats until the user responds either no, n or q.
=end
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

=begin
A random number between 1 and 3999 is generated. The user gets 3 attempts to convert it correctly to Roman numerals. If the user either gets it right or their three tries are up, they get the choice to practice again. The function repeats with a new random number until the user quits.
=end
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

=begin
Question object that takes a question and a multiple choice answer as an argument
=end
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

=begin
Function that runs the test with 5 set questions and prints how many the user got correct
=end 
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

=begin
Quits the program
=end
def quit_application
  puts "Thank you for using the Roman Numeral Converter! We hope you learnt something new!"
end

=begin
Program begins
=end
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