board = %w[1 2 3 4 5 6 7 8 9]

module WinComponents
  def valid_input?(board, value)
    value.between?(1, 9) && board[value - 1].to_i == value
  end

  def check_rows(board, string)
    3.times do |i|
      return true if board[i * 3] == string && board[i * 3 + 1] == string && board[i * 3 + 2] == string
    end
    false
  end

  def check_columns(board, string)
    3.times do |i|
      return true if board[i] == string && board[i + 3] == string && board[i + 6] == string
    end
    false
  end

  def check_diagonals(board, string)
    return true if board[0] == string && board[4] == string && board[8] == string
    return true if board[2] == string && board[4] == string && board[6] == string

    false
  end

  def can_win(board, string)
    if check_rows(board, string) || check_columns(board, string) || check_diagonals(board, string)
      display(board)
      puts "Congrats! #{name} Won!"
      exit
    end

    false
  end
end

class Player
  def initialize(name, piece)
    @name = name
    @piece = piece
    @string = piece == 1 ? 'X' : 'O'
  end

  attr_reader :name, :piece

  include WinComponents

  def input(board)
    display(board)
    print "#{name}, where do you want to place your piece?: "
    value = 0
    until valid_input?(board, value)
      value = gets.chomp.to_i
      puts 'Invalid number. Please try again.' unless valid_input?(board, value)
    end
    board[value - 1] = (piece == 1 ? 'X' : 'O')
    can_win(board, piece == 1 ? 'X' : 'O')
  end
end

def display(board)
  puts "
   #{board[0]} | #{board[1]} | #{board[2]}
   ---------
   #{board[3]} | #{board[4]} | #{board[5]}
   ---------
   #{board[6]} | #{board[7]} | #{board[8]}
   "
end

print "Player 1's Name: "
player1 = Player.new(gets.chomp, rand < 0.5 ? 1 : -1)

print "Player 2's Name: "
player2 = Player.new(gets.chomp, player1.piece * -1)

whos_turn = rand < 0.5

9.times do
  whos_turn ? player1.input(board) : player2.input(board)
  whos_turn = !whos_turn
end
