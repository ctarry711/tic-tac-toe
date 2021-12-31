class Game

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_player = @player1
    @board = Array.new(3) { Array.new(3) }
  end

  def row_complete?(token)
    @board.any? do |row|
      row.all? {|position| position == token}
    end
  end

  def col_complete?(token)
    board_trans = @board.transpose
    board_trans.any? do |row|
      row.all? {|position| position == token}
    end
  end

  def diag_complete?(token)
    diag = (0..2).collect { |i| @board[i][i] }
    diag.all? { |position| position == token }
  end

  def player_won?(player)
    row_complete?(player.token) || col_complete?(player.token) || diag_complete?(player.token)
  end

  def position_free?(position)
    @board[position[0] - 1][position[1] - 1].nil?
  end

  def play
    puts "Let's play Tic Tac Toe!"
    puts 'Here is the Board:'
    draw_board
    loop do
      make_move(@current_player)
      if player_won?(@current_player)
        puts "Congratulations #{@current_player.name}, you have won!"
        return
      end
      @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
    end
  end

  def make_move(player)
    loop do
      move = player.choose_move
      row = move[0]
      column = move[1]
      if position_free?(move)
        puts "#{player.name} made a move at row #{row}, and column #{column}"
        @board[row - 1][column - 1] = player.token
        draw_board
        break
      end
      puts "#{row}, #{column} is not available. Please make another Choice"
      draw_board
    end
  end

  def draw_board
    @board.each_with_index do |row, index|
      puts "#{row[0].nil? ? '   ' : ' '+ row[0] +' '}|#{row[1].nil? ? '   ': ' ' + row[1]+ 
        ' '}|#{row[2].nil? ? '   ': ' ' + row[2] + ' '}"
      unless index == 2
        puts '-----------'
      end
    end
  end
end

class Player
  attr_reader :name, :token

  def initialize(name, token)
    @name = name
    @token = token
  end

  def choose_move
    puts "#{@name}, please input a move (row, column)"
    gets.chomp.split(",").map { |i| i.strip.to_i }
  end
end

class HumanPlayer < Player
end

class ComputerPlayer
end

player1 = Player.new("Chris", "X")
player2 = Player.new("Zach", "O")
new_game = Game.new(player1, player2)

new_game.play