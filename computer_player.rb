class ComputerPlayer
  def initialize(colors)
    @colors = colors
  end

  def get_guess(previous_results)
    guess = Array.new(4) { @colors.sample }
    puts "Computer's guess: #{guess.join}"
    guess
  end
end
