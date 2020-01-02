class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def add_random_color
    self.seq << COLORS.sample
  end

  def play
    until game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    unless game_over
      round_success_message
      self.sequence_length += 1
    end
  end

  def show_sequence
    self.seq.each do |color|
      puts color
      sleep(0.5)
      system("clear")
    end
    add_random_color
  end

  def require_sequence    

    puts "Repeat the sequence by entering the color followed by a new line: "
    self.seq.each do |color|
      user_input = gets.chomp
      if color != user_input
        self.game_over = true
        break
      end
    end

  end

  def round_success_message
    puts "Good job! Get ready for the next round:"
  end

  def game_over_message
    puts "Sorry, that was incorrect."
    puts "You lasted #{self.sequence_length - 1} turns."
    puts "Game Over!"
  end

  def reset_game
    self.sequence_length = 1
    self.game_over = false
    self.seq = []
  end
end
