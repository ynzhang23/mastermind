require "pry-byebug"

module Colors
  AVAILABLE_COLOR = ['R', 'O', 'Y', 'G', 'B', 'P']
end

class Attempt
  attr_reader :attempt_array

  def initialize
    @attempt_array = [nil, nil, nil, nil]
  end

  def get_guess
    # Instructions
    puts "Decode!!! The available colors are: "
    puts "-------------------------------------"
    puts "R: Red\nO: Orange\nY: Yellow\nG: Green\nB: Blue\nP: Purple"
    puts "-------------------------------------"
    # Update the current guess array
    @attempt_array = @attempt_array.each_with_index.map do |value, index|
    puts "Enter a color for Position #{index + 1}: " 
    value = gets.chomp
    end
  end

  def update_attempt
    return " (#{@attempt_array[0]})  (#{@attempt_array[1]})  (#{@attempt_array[2]})  (#{@attempt_array[3]}) "
  end
end

class Answer
  include Colors
  attr_reader :answer

  def initialize
    @answer = Colors::AVAILABLE_COLOR.sample(4)
  end

  def feedback(code)
    
  end
end

# Generate code
generated_code = Answer.new
puts generated_code.answer

# User attempts
attempt_board = Attempt.new
attempt_board.get_guess
puts attempt_board.attempt_array

# 
puts attempt_board.update_attempt + " || "