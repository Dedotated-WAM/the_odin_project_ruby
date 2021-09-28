require_relative '../lib/connect_four'

describe ConnectFour::Game do
  describe '#initialize' do
    subject(:game_initialize) { described_class.new }

    context 'when initialized' do
      it 'creates player_one and sets player_one.symbol to a black_circle' do
        black_circle = "\u26AB".encode('utf-8')
        player_name = 'Player One'
        expect(game_initialize.player_one.name).to eql(player_name)
        expect(game_initialize.player_one.symbol).to eq(black_circle)
      end

      it 'creates player_two and sets player_two.symbol to a red_circle' do
        red_circle = "\u{1F534}".encode('utf-8')
        player_name = 'Player Two'
        expect(game_initialize.player_two.name).to eq(player_name)
        expect(game_initialize.player_two.symbol).to eq(red_circle)
      end
    end
  end

  describe '#valid_column?' do
    subject(:game_column_valid) { described_class.new }

    context 'when user input is between arguments' do
      it 'returns true' do
        valid_column = '1'
        expect(game_column_valid).to receive(:valid_column?).with(valid_column).and_return(true)
        game_column_valid.valid_column?(valid_column)
      end
    end

    context 'when user provides invalid input' do
      it 'returns false' do
        invalid_column_one = 'A'
        invalid_column_two = 10
        expect(game_column_valid).to receive(:valid_column?).with(invalid_column_one).and_return(false)
        expect(game_column_valid).to receive(:valid_column?).with(invalid_column_two).and_return(false)
        game_column_valid.valid_column?(invalid_column_one)
        game_column_valid.valid_column?(invalid_column_two)
      end
    end
  end

  describe '#solicit_move' do
    subject(:game_solicit) { described_class.new }
    greeting = 'Test Player: Enter a column number between 1 and 7 to drop your chip.'
    player_name = 'Test Player'

    context 'when called' do
      it 'prompts for user input' do
        allow(game_solicit.current_player).to receive(:name).and_return(player_name)
        expect(game_solicit).to receive(:puts).with(greeting)
        allow(game_solicit).to receive(:gets).and_return('1\n')
        game_solicit.solicit_move
      end

      it 'updates @current_move with valid input' do
        allow(game_solicit).to receive(:gets).and_return('1\n')
        game_solicit.solicit_move
        expect(game_solicit.instance_variable_get(:@current_move)).to eq(0)
      end
    end

    context 'when user inputs an invalid column number, then inputs a valid column number' do
      it 'completes loop and displays an invalid input error message once' do
        invalid_input = "10\n"
        valid_input = "3\n"
        allow(game_solicit.current_player).to receive(:name).and_return(player_name)
        @minimum = game_solicit.instance_variable_get(:@minimum)
        @maximum = game_solicit.instance_variable_get(:@maximum)
        error_message = "Error!  Input must be a number between #{@minimum} and #{@maximum}"
        allow(game_solicit).to receive(:puts).with(greeting).twice
        expect(game_solicit).to receive(:puts).with(error_message).once
        allow(game_solicit).to receive(:gets).and_return(invalid_input, valid_input)
        game_solicit.solicit_move
        expect(game_solicit.instance_variable_get(:@current_move)).to eq(2)
      end
    end

    context 'when a user inputs a column value which is already full, followed by a non-full column value' do
      let(:black_circle) { "\u26AB".encode('utf-8') }
      let(:red_circle) { "\u{1F534}".encode('utf-8') }

      it 'completes loop and displays an invalid column input error message once' do
        game_solicit.board.grid[0] = [
          black_circle,
          black_circle,
          red_circle,
          black_circle,
          red_circle,
          red_circle,
          black_circle
        ]
        invalid_input = "1\n"
        valid_input = "2\n"
        error_message = "Column '1' is full. Please make a different selection."
        allow(game_solicit.current_player).to receive(:name).and_return(player_name)
        allow(game_solicit).to receive(:gets).and_return(invalid_input, valid_input)
        expect(game_solicit).to receive(:puts).with(greeting).twice
        expect(game_solicit).to receive(:puts).with(error_message).once
        game_solicit.solicit_move
        expect(game_solicit.instance_variable_get(:@current_move)).to eq(1)
      end
    end
  end

  describe '#valid_column' do
    subject(:game_column) { described_class.new }
    context 'when given an invalid column value' do
      it 'returns false' do
        invalid_column_one = 'a'
        invalid_column_two = (game_column.instance_variable_get(:@maximum) + 1).to_s
        expect(game_column).to receive(:valid_column?).with(invalid_column_one).and_return(false)
        expect(game_column).to receive(:valid_column?).with(invalid_column_two).and_return(false)
        game_column.valid_column?(invalid_column_one)
        game_column.valid_column?(invalid_column_two)
      end
    end

    context 'when given a valid column value' do
      it 'returns true' do
        valid_column = '5'
        expect(game_column).to receive(:valid_column?).with(valid_column).and_return(true)
        game_column.valid_column?(valid_column)
      end
    end
  end

  describe '#play_again' do
    subject(:game_again) { described_class.new }

    context 'when user wants to play again' do
      it 'returns true' do
        valid_input = "Y\n"
        allow(game_again).to receive(:puts)
        allow(game_again).to receive(:gets).and_return(valid_input)
        expect(game_again).to receive(:play_again?).and_return(true)
        game_again.play_again?
      end
    end

    context 'when user does not want to play again' do
      it 'returns false' do
        valid_input = "n\n"
        allow(game_again).to receive(:gets).and_return(valid_input)
        allow(game_again).to receive(:puts)
        expect(game_again.play_again?).to be(false)
        game_again.play_again?
      end
    end

    context 'when user provides invalid input then valid input' do
      it 'displays error message once and completes loop' do
        invalid_input = "q\n"
        valid_input = "no\n"
        error_message = 'Invalid entry'
        allow(game_again).to receive(:gets).and_return(invalid_input, valid_input)
        allow(game_again).to receive(:puts)
        expect(game_again).to receive(:puts).with(error_message).once
        expect(game_again.play_again?).to be(false)
        game_again.play_again?
      end
    end
  end

  describe '#play_game' do
    subject(:game_play) { described_class.new }
    context 'when player decides to play again' do
      before do
        game_play.instance_variable_set(:@current_move, 0)
        game_play.instance_variable_set(:@current_player, instance_double('Player', name: 'Test Player', symbol: 'X'))
        allow(game_play).to receive(:puts)
        allow(game_play).to receive(:solicit_move).and_return(0)
        allow(game_play.board).to receive(:place_symbol).with(game_play.current_move, game_play.current_player)
        allow(game_play.board).to receive(:winner?).and_return(true)
      end
      it 'returns nil' do
        allow(game_play).to receive(:play_again?).and_return(true)
        expect(game_play).to receive(:play_game).and_return(nil)
        game_play.play_game
      end
    end

    context 'when the player decides to quit' do
      it 'exits program' do
        allow(game_play).to receive(:play_again?).and_return(false)
        expect(game_play).to receive(:play_game).and_return(1)
        game_play.play_game
      end
    end
  end
end
