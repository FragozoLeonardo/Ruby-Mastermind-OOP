class Board
  COLORS = %w[R G B Y O P].freeze

  attr_reader :previous_results

  def initialize
    @secret_code = []
    @previous_results = []
  end

  def generate_secret_code
    @secret_code = Array.new(4) { COLORS.sample }
  end

  def evaluate_guess(guess)
    exact_matches = 0
    color_matches = 0

    secret_code_copy = @secret_code.dup
    guess.each_with_index do |color, index|
      if secret_code_copy[index] == color
        exact_matches += 1
        secret_code_copy[index] = nil
        guess[index] = nil
      end
    end

    guess.each do |color|
      next if color.nil?

      if secret_code_copy.include?(color)
        color_matches += 1
        secret_code_copy[secret_code_copy.index(color)] = nil
      end
    end

    result = [exact_matches, color_matches]
    @previous_results << result
    result
  end

  def get_secret_code_from_player
    loop do
      print 'Enter the secret code (e.g., RGBY): '
      @secret_code = gets.chomp.upcase.chars

      if @secret_code.length == 4 && (@secret_code - COLORS).empty?
        break
      else
        puts 'Invalid secret code! Please enter a valid code with four colors.'
      end
    end
  end

  def secret_code
    @secret_code.dup
  end
end
