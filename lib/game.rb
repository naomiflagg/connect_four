class Game
  require_relative('board.rb')
  require_relative('player.rb')
  require 'pry'

  attr_accessor :board, :player1, :player2, :current_player

  def initialize
    @board = Board.new
    @player1 = Player.new('Player 1', "\u{2600}")
    @player2 = Player.new('Player 2', "\u{2603}")
    @current_player = @player1
  end

  def begin_game
    display_instructions
    change_player_name(player1)
    change_player_name(player2)
    play_turn
  end

  def display_instructions
    puts "Welcome to Connect Four! In this game, you'll choose a column.\n" \
    'for your token. The first player to get four consecutive token wins.'
  end

  def change_player_name(player)
    puts "#{player.name} Enter your name."
    player.name = gets.chomp
  end

  def play_turn
    loop do
      @board.display
      col = request_move
      row = @board.find_avail_row(col - 1)
      @board.add_piece(row, col - 1, @current_player.token)
      break if game_over?

      switch_player
    end
  end

  def request_move
    puts "#{current_player.name}, which column would you like to put your token in? " \
      'Enter a number 1-7.'
    loop do
      col = gets.chomp.to_i
      return col if col.between?(1, 7)

      puts 'Entry needs to be a number between 1 and 7. Try again.'
    end
  end

  def game_over?
    if @board.four_consecutive?
      p "#{@current_player.name} wins!"
      true
    elsif @board.full?
      p 'Tie game!'
      true
    end
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
    puts "Thanks. #{@current_player.name}, you're up!"
  end
end

# game = Game.new
# game.begin_game
