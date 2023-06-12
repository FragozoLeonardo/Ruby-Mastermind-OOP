class Board
  COLORS = ['R', 'G', 'B', 'Y', 'O', 'P'].freeze

  def initialize
    @secret_code = generate_secret_code
  end

  def evaluate_guess(guess)
    code_copy = @secret_code.dup
    correct_color_position = 0
    correct_color = 0

    guess.each_with_index do |color, index|
      if color == code_copy[index]
        correct_color_position += 1
        code_copy[index] = nil
        guess[index] = nil
      end
    end

    guess.each do |color|
      if color && code_copy.include?(color)
        correct_color += 1
        code_copy[code_copy.index(color)] = nil
      end
    end

    [correct_color_position, correct_color]
  end

  private

  def generate_secret_code
    Array.new(4) { COLORS.sample }
  end
end
