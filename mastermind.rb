require "pry-byebug"

module Colors
  AVAILABLE_COLOR = ['R', 'O', 'Y', 'G', 'B', 'P']
end

class Codebreaker
  include Colors
  attr_reader :codebreaker_array, :round_number

  def initialize
    @codebreaker_array = [nil, nil, nil, nil]
    @round_number = 0
  end

  def get_guess
    # Instructions
    @round_number += 1
    puts "Round #{@round_number}! The available colors are: "
    puts "-------------------------------------"
    puts "R: Red        O: Orange\nY: Yellow     G: Green\nB: Blue       P: Purple"
    puts "-------------------------------------"
    # Update the current guess array
    @codebreaker_array = @codebreaker_array.each_with_index.map do |value, index|
      puts "Enter a color for Position #{index + 1}: "
      input = gets.chomp
      # If input is not part of the six colors, ask again
      until Colors::AVAILABLE_COLOR.include? input do
        puts "Enter a color for Position #{index + 1}: "
        input = gets.chomp
      end
      value = input
    end
  end

  def update_codebreaker
    return " (#{@codebreaker_array[0]})  (#{@codebreaker_array[1]})  (#{@codebreaker_array[2]})  (#{@codebreaker_array[3]}) "
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

# Codebreaker attempts
codebreaker_board = Codebreaker.new
codebreaker_board.get_guess
puts codebreaker_board.codebreaker_array

# 
puts codebreaker_board.update_codebreaker + " || "