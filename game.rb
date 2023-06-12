require_relative 'player'
require_relative 'computer_player'
require_relative 'board'

class Game
  MAX_ROUNDS = 12

  def initialize
    @board = Board.new
    @player = nil
  end

  def start
    puts 'Welcome to Mastermind!'
    puts 'The colors are represented by the following letters:'
    puts 'R - Red, G - Green, B - Blue, Y - Yellow, O - Orange, P - Purple'

    choice = get_player_choice
    if choice == '1'
      @player = Player.new
    elsif choice == '2'
      @player = ComputerPlayer.new(Board::COLORS)
    else
      puts 'Invalid choice! Please choose 1 or 2.'
      return
    end

    puts 'Can you guess the secret code?'

    MAX_ROUNDS.times do |round|
      puts "\nRound #{round + 1}:"

      user_guess = @player.get_guess
      result = @board.evaluate_guess(user_guess)

      if result == [4, 0]
        puts 'Congratulations! You guessed the code!'
        return
      else
        puts "Result: #{result[0]} correct color and position, #{result[1]} correct color but wrong position"
      end
    end

    puts "Game over! You couldn't guess the code. The secret code was #{board.secret_code.join}."
  end

  private

  def get_player_choice
    loop do
      puts "\nMenu:"
      puts '1. Play as a human'
      puts '2. Play against the computer'
      print 'Enter your choice (1 or 2): '
      choice = gets.chomp

      return choice if ['1', '2'].include?(choice)

      puts 'Invalid choice! Please choose 1 or 2.'
    end
  end
end

game = Game.new
game.start
