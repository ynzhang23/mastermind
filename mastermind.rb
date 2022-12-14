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

  def update_codebreaker_board
    return " (#{@codebreaker_array[0]})  (#{@codebreaker_array[1]})  (#{@codebreaker_array[2]})  (#{@codebreaker_array[3]}) "
  end
end

class Codemaker
  include Colors
  attr_reader :code, :feedback_array

  def initialize
    @code = [Colors::AVAILABLE_COLOR.sample(), Colors::AVAILABLE_COLOR.sample(), Colors::AVAILABLE_COLOR.sample(), Colors::AVAILABLE_COLOR.sample()] 
    @feedback_array = Array.new(4)
  end

  def give_feedback(guess_array)
    # Create duplicate array for comparison to prevent original array from being altered
    temp_code_array = @code.dup
    temp_guess_array = guess_array.dup
    temp_feedback_array = [nil, nil, nil, nil]
    # Condition: Position and Color are both correct
    temp_guess_array.each_with_index do |color, index|
      if color == temp_code_array[index]
        temp_feedback_array[index] = "*"
        temp_code_array[index] = nil
        temp_guess_array[index] = "guessed"
      end
    end
    # Condition: Color is included in the array
    temp_guess_array.each_with_index do |color, index|
      if temp_code_array.include? color
        temp_feedback_array[index] = "o"
        # Remove the guessed color from the code to prevent duplication issue
        temp_code_array[temp_code_array.index(color)] = nil
      end
    end
    @feedback_array = temp_feedback_array
  end

  def update_codemaker_board
    return " (#{@feedback_array[0]})  (#{@feedback_array[1]})  (#{@feedback_array[2]})  (#{@feedback_array[3]}) "
  end

end

# Print Title
puts "
███╗░░░███╗░█████╗░░██████╗████████╗███████╗██████╗░███╗░░░███╗██╗███╗░░██╗██████╗░
████╗░████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗░████║██║████╗░██║██╔══██╗
██╔████╔██║███████║╚█████╗░░░░██║░░░█████╗░░██████╔╝██╔████╔██║██║██╔██╗██║██║░░██║
██║╚██╔╝██║██╔══██║░╚═══██╗░░░██║░░░██╔══╝░░██╔══██╗██║╚██╔╝██║██║██║╚████║██║░░██║
██║░╚═╝░██║██║░░██║██████╔╝░░░██║░░░███████╗██║░░██║██║░╚═╝░██║██║██║░╚███║██████╔╝
╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═════╝░░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝╚═╝░░╚══╝╚═════╝░"
puts "---------------------------------------------------------------------------------"

# Generate code
codemaker_board = Codemaker.new
puts codemaker_board.code

# Create Codebreaker
codebreaker_board = Codebreaker.new

# Loop until code is correct
until codemaker_board.feedback_array == ['*', '*', '*', '*'] do
  # Codebreaker attempts and updates his guessed code
  codebreaker_board.get_guess
  # Codemaker feedback according to codebreaker's guessed code
  codemaker_board.give_feedback(codebreaker_board.codebreaker_array)
  # Output result of the input 
  puts codebreaker_board.update_codebreaker_board + " || " + codemaker_board.update_codemaker_board
  # Reset feedback tray to empty
end