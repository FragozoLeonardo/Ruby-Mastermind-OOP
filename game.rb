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
      @board.generate_secret_code
    elsif choice == '2'
      @player = ComputerPlayer.new(Board::COLORS)
      @board.get_secret_code_from_player
    else
      puts 'Invalid choice! Please choose 1 or 2.'
      return
    end

    puts 'Let the game begin!'

    MAX_ROUNDS.times do |round|
      puts "\nRound #{round + 1}:"

      if @player.is_a?(Player)
        user_guess = @player.get_guess
      else
        user_guess = @player.get_guess(@board.previous_results)
      end

      result = @board.evaluate_guess(user_guess)

      if result == [4, 0]
        puts 'Congratulations! The computer guessed the code!'
        return
      else
        puts "Result: #{result[0]} correct color and position, #{result[1]} correct color but wrong position"
      end
    end

    puts 'Game over! The computer could not guess the code.'
    puts "The secret code was: #{@board.secret_code.join}."
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
