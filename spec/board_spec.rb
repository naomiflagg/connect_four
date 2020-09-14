require './lib/board.rb'

describe Board do
  let(:board) { Board.new }
  let(:grid) { board.grid }

  describe '#initialize' do
    it 'creates a 6 x 7 array object' do
      expect(grid.size).to eq(6)
      expect(grid).to be_instance_of Array
    end
  end

  describe '#find_avail_row' do
    it 'finds first available row, given the specified column' do
      grid[5][2] = 'X'
      grid[4][2] = 'O'
      expect(board.find_avail_row(2)).to eq(3)
    end

    it 'returns nil if no space is available in column' do
      (0..5).each do |row|
        grid[row][2] = 'X'
      end
      expect(board.find_avail_row(2)).to be_nil
    end
  end

  describe '#add_piece' do
    it 'adds the specified token to the specified space, given row and column' do
      board.add_piece(5, 4, 'X')
      expect(grid[5][4]).to eq('X')
    end
  end

  describe '#four_consecutive?' do
    it 'returns true if there are four consecutive tiles in a row' do
      (3..6).each do |col|
        grid[1][col] = 'X'
      end
      expect(board.four_consecutive?).to be_truthy
    end

    it 'returns true if there are four consecutive tiles in a column' do
      (2..5).each do |row|
        grid[row][4] = 'O'
      end
      expect(board.four_consecutive?).to be_truthy
    end

    it 'returns true if there are four consecutive tiles in a diagonal' do
      (1..4).each do |num|
        grid[num][num] = 'O'
      end
      expect(board.four_consecutive?).to be_truthy
    end
  end

  describe '#full?' do
    it 'returns true if board has no blank spaces' do
      board.grid = [%w[X X Y], [1, 3, 5]]
      expect(board.full?).to be_truthy
    end

    it 'returns false if board contains any blank spaces' do
      expect(board.full?).to be false
    end
  end
end
