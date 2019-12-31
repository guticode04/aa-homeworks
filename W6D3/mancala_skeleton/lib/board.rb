class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) {Array.new}
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    (0...cups.length).each do |idx|
      next if idx == 6 || idx == 13
      cups[idx] = [:stone,:stone,:stone,:stone]
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if !start_pos.between?(1,6) || !start_pos.between?(7,12)
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    #empty cup at start_pos
    pebbles = @cups[start_pos]
    @cups[start_pos]

    current_cup = start_pos
    until pebbles.empty?
      current_cup += 1
      #make sure we are using proper index for cup
      current_cup = 0 if current_cup > 13
      #check to see if we are passing player store
      if current_cup == 6
        @cups[6] << pebbles.shift if current_player_name == @name1
      elsif current_cup == 13
        @cups[13] << pebbles.shift if current_player_name == @name2
      else
        @cups[current_cup] << pebbles.shift
      end
    end
    render
    next_turn(current_cup)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether 
    # make_move returns :switch, :prompt, or ending_cup_idx
    if @cups[ending_cup_idx].length == 1
      :switch
    elsif ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    else
      ending_cup_idx
    end

  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[1..6].all?(&:empty?) || @cups[7..12].all?(&:empty?)
  end

  def winner
    player1_score = @cups[6].length
    player2_score = @cups[13].length

    if player1_score == player2_score
      :draw
    else
      if player1_score > player2_score
        @name1
      else
        @name2
      end
    end
  end
end
