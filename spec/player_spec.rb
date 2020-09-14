require './lib/player.rb'

describe Player do
  let(:player) { Player.new('Jane', 'X') }

  describe '#initialize' do
    it 'initializes with name and token variables' do
      expect(player.name).to eq('Jane')
      expect(player.token).to eq('X')
    end
  end
end
