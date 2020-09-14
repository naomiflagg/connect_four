class Board
  attr_accessor :grid

  require 'pry'

  def initialize
    @blank = '|   '
    @grid = Array.new(6) { Array.new(7, @blank) }
  end

  def display
    board_break = '------------------------------------'
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
    @grid[row][col] = "| #{token} "
  end

  def four_consecutive?(winnable_arrays = [@grid, @grid.transpose, make_diag_arrays])
    count = 1
    winnable_arrays.each do |arrays|
      arrays.each do |array|
        array.each_index do |idx|
          return true if count == 4

          # Check if next element in array is the same, but not blank
          array[idx] == array[idx + 1] && array[idx] != @blank ? count += 1 : count = 1
        end
      end
    end
    false
  end

  def make_diag_arrays
    @diag_arys = []
    # Loop through first three rows of grid, iterating diagonally, right then left
    (0..2).each do |row|
      (0..3).each do |col|
        @diag_arys << diag([row, col], 'right')
      end
      (3..6).each do |col|
        @diag_arys << diag([row, col], 'left')
      end
    end
    diag_values
  end

  def full?
    @grid.each do |row|
      return false if row.include?(@blank)
    end
    true
  end

  private

  def diag(start, direction)
    out = [start]
    direction = (direction == 'left') ? -1 : 1
    # Add coordinates of space that is diagonal to the last one entered
    3.times do
      out << [out.last[0] + 1, out.last[1] + direction]
    end
    out
  end

  def diag_values
    diag_values = []
    @diag_arys.each do |array|
      # Use diagonal coordinates to populate new array with corresponding values
      new_array = array.map do |ele|
        row = ele[0]
        col = ele[1]
        @grid[row][col]
      end
      diag_values << new_array
    end
    diag_values
  end
end
