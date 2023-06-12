class Player
  def get_guess
    loop do
      print 'Enter your guess (e.g., RGBY): '
      user_guess = gets.chomp.upcase.chars

      if user_guess.length == 4 && (user_guess - Board::COLORS).empty?
        return user_guess
      else
        puts 'Invalid guess! Please enter a valid guess with four colors.'
      end
    end
  end
end
