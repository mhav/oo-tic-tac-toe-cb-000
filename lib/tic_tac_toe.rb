class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [0,4,8],
    [1,4,7],
    [2,5,8],
    [2,4,6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(string_input)
    string_input.to_i - 1
  end

  def move(index, who = current_player())
    @board[index] = who
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn_count
    occupied_fields_count = 0
    @board.each do |field|
      if field == "X" || field == "O"
        occupied_fields_count += 1
      end
    end
    occupied_fields_count
  end

  def current_player
    (turn_count()) % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    who = current_player()
    if valid_move?(index)
      move(index, who)
      display_board()
    else
      turn()
    end
  end

  def check_for_win(win_combination)
    position_1 = @board[win_combination[0]]
    position_2 = @board[win_combination[1]]
    position_3 = @board[win_combination[2]]
    win = false

    if position_taken?(win_combination[0]) && position_taken?(win_combination[1]) && position_taken?(win_combination[2])
      if position_1 == position_2 && position_1 == position_3 && position_2 == position_3
        win = true
      end
    end
    win
  end

  def full?
    if @board.all?{|i| i != " "}
      return true
    end
  end

  def won?
    # check if board is empty and return false if so
    if @board.all?{|i| i == " "}
      return false
    end

    WIN_COMBINATIONS.each do |win_combination|
      if check_for_win(win_combination)
        return win_combination
      end
    end

    if full?
      false
    end
  end

  def draw?
    winner = won?
    full_board = full?
    if !winner && full_board
      true
    elsif !winner && !full_board
      false
    elsif winner
      false
    end
  end

  def over?
    if won? || full? || draw?
      true
    else
      false
    end
  end

  def winner
    if !won?
      return nil
    elsif
      winning_comb = won?
      winner_symbol = @board[winning_comb[0]]
      return winner_symbol
    elsif draw?
      nil
    end
  end

  def play
    round = 0
    until over? == true
      turn()
      round += 1
    end

    if won?
      symbol = winner
      puts "Congratulations #{symbol}!"
    elsif draw?
       puts "Cat's Game!"
    end
  end

end
