require './lib/game.rb'

describe Game do
  let(:game) { Game.new }

  describe '#initialize' do
    it 'creates a board object' do
      expect(game.board).to be_an_instance_of(Board)
    end

    it 'creates player objects' do
      expect(game.player1).to be_an_instance_of(Player)
    end

    it 'sets current player to be player1' do
      expect(game.current_player).to eq(game.player1)
    end
  end

  describe '#display_instructions' do
    it 'displays game instructions' do
      expect { game.display_instructions }.to \
        output(/#{Regexp.quote('Welcome to Connect Four!')}/).to_stdout
    end
  end

  describe '#change_player_name' do
    it "sets players' names based on input" do
      allow(game).to receive(:gets).and_return('Naomi')
      game.change_player_name(game.player1)
      expect(game.player1.name).to eq('Naomi')
    end
  end

  describe '#request_move' do
    before do
      allow(game).to receive(:loop).and_yield.and_yield
    end

    context 'user inputs a single number' do
      before do
        allow(game).to receive(:gets).and_return('2')
      end

      it 'returns numerical of user input' do
        expect(game.request_move).to eq(2)
      end

      it 'breaks the loop' do
        expect(game).to receive(:gets).once
        game.request_move
      end
    end

    context 'user inputs an incorrect value' do
      it 'continues to loop' do
        allow(game).to receive(:gets).and_return('Hi', '0')
        expect(game).to receive(:gets).exactly(:twice)
        game.request_move
      end
    end
  end

  describe '#game_over?' do
    it 'returns true if there are four consecutive pieces' do
      allow(game.board).to receive(:four_consecutive?).and_return(true)
      expect(game.game_over?).to be true
    end

    it 'returns true if the board is full' do
      allow(game.board).to receive(:full?).and_return(true)
      expect(game.game_over?).to be true
    end
  end

  describe '#switch_player' do
    it 'toggles the value of @current_player between player1 and player2' do
      game.current_player = game.player1
      game.switch_player
      expect(game.current_player).to eq(game.player2)
    end
  end
end
