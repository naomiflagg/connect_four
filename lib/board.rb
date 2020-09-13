class Board
  attr_accessor :grid

  require 'pry'

  def initialize
    @blank = '|  '
    @grid = Array.new(6) { Array.new(7, @blank) }
  end

  def display
    board_break = '-----------------------------'
    puts board_break
    @grid.each do |row|
      puts "#{row.join(' ')} |"
      puts board_break
    end
  end

  def find_avail_row(col)
    5.downto(0) do |row|
      return row if @grid[row][col] == @blank
    end
    nil
  end

  def add_piece(row, col, token)
    @grid[row][col] = token
  end

  def four_consecutive?(arrays)
    count = 1
    arrays.each do |array|
      array.each_index do |idx|
        return true if count == 4

        # Check if next element in array is the same, but not blank
        array[idx] == array[idx + 1] && array[idx] != @blank ? count += 1 : count = 1
      end
    end
    false
  end

  def diag(start, direction)
    out = [start]
    direction = (direction == 'left') ? -1 : 1
    3.times do 
      out << [out.last[0] + 1, out.last[1] + direction]
    end
  end

  def make_diag_arrays
    diag_arys = []
    (0..2).each do |row|
      (0..3).each do |col|
        diag_arys << diag([row, col], 'right')
      end 
      (3..6).each do |col|
        diag_arys << diag([row, col], 'left')
      end
    end
  end 

  # FUnction to populate diagonal arrays with values

board = Board.new
board.display

