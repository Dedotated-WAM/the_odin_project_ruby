require_relative '../lib/connect_four'

describe ConnectFour::Board do
  let(:white_circle) { ConnectFour::WHITE_CIRCLE }
  let(:black_circle) { ConnectFour::BLACK_CIRCLE }
  let(:red_circle) { ConnectFour::RED_CIRCLE }

  include ConnectFour
  describe '#default_grid' do
    subject(:board_grid) { described_class.new }

    context 'when initialized' do
      it 'creates a default_grid' do
        expect(board_grid.default_grid).to_not be nil
      end

      it 'sets default_grid size to 7 columns' do
        expect(board_grid.grid.length).to eq(7)
      end

      it 'sets default_grid size to 6 rows' do
        expect(board_grid.grid.transpose.length).to eq(6)
      end
    end
  end

  describe '#column_full?' do
    subject(:board) { described_class.new }
    context 'when a column is full' do
      it 'returns true' do
        board.grid[0] = board.grid[0].each.map { '*' }
        expect(board).to receive(:column_full?).with(0).and_return(true)
        board.column_full?(0)
      end
    end

    context 'when a column is not full' do
      it 'returns false' do
        expect(board).to receive(:column_full?).with(0).and_return(false)
        board.column_full?(0)
      end
    end
  end

  describe '#place_symbol' do
    subject(:board_symbol) { described_class.new }

    context 'when place_symbol is called' do
      it 'places the player symbol in the current_move column' do
        current_player = instance_double('Player', name: 'Test Player', symbol: 'X')
        current_move = 0
        board_symbol.place_symbol(current_move, current_player)
        expect(board_symbol.grid[0]).to include('X')
      end
    end
  end

  describe '#winner?' do
    subject(:board_winner) { described_class.new }
    context 'when 4 consecutive player symbols appear vertically on the board' do
      before do
        board_winner.grid[0][0] = black_circle
        board_winner.grid[0][1] = black_circle
        board_winner.grid[0][2] = black_circle
        board_winner.grid[0][3] = black_circle
        board_winner.display_grid
      end

      it 'returns true' do
        expect(board_winner.winner?).to be(true)
        board_winner.winner?
      end
    end

    context 'when 4 consecutive player symbols appear horizontally on the board' do
      before do
        board_winner.grid[0][0] = red_circle
        board_winner.grid[1][0] = red_circle
        board_winner.grid[2][0] = red_circle
        board_winner.grid[3][0] = red_circle
        board_winner.display_grid
      end
      it 'returns true' do
        expect(board_winner.winner?).to be(true)
        board_winner.winner?
      end
    end

    context 'when 4 consecutive player symbols appear diagonally on the board' do
      before do
        board_winner.grid[0][0] = black_circle
        board_winner.grid[1][1] = black_circle
        board_winner.grid[2][2] = black_circle
        board_winner.grid[3][3] = black_circle
        board_winner.display_grid
      end
      it 'returns true' do
        expect(board_winner.winner?).to be(true)
        board_winner.winner?
      end
    end

    context 'when less than 4 consecutive player symbols appear horizontally on the board' do
      before do
        board_winner.grid[0][0] = black_circle
        board_winner.grid[1][0] = black_circle
        board_winner.grid[2][0] = black_circle
        board_winner.grid[3][0] = red_circle
        board_winner.grid[4][0] = black_circle
        board_winner.grid[5][0] = black_circle
        board_winner.grid[6][0] = black_circle
        board_winner.display_grid
      end
      it 'returns false' do
        expect(board_winner.winner?).to be(false)
        board_winner.winner?
      end
    end

    context 'when less than 4 consecutive player symbols appear vertically on the board' do
      before do
        board_winner.grid[0][0] = black_circle
        board_winner.grid[0][1] = black_circle
        board_winner.grid[0][2] = black_circle
        board_winner.grid[0][3] = red_circle
        board_winner.grid[0][4] = black_circle
        board_winner.grid[0][5] = black_circle
        board_winner.display_grid
      end
      it 'returns false' do
        expect(board_winner.winner?).to be(false)
        board_winner.winner?
      end
    end

    context 'when less than 4 consecutive player symbols appear diagonally on the board' do
      before do
        board_winner.grid[0][0] = black_circle
        board_winner.grid[1][1] = black_circle
        board_winner.grid[2][2] = black_circle
        board_winner.grid[3][3] = red_circle
        board_winner.grid[4][4] = black_circle
        board_winner.grid[5][5] = black_circle
        board_winner.display_grid
      end
      it 'returns false' do
        expect(board_winner.winner?).to be(false)
        board_winner.winner?
      end
    end
  end

  describe '#diagonals' do
    subject(:board_diagonals) { described_class.new }
    context 'when called' do
      it 'returns an array of 6 diagonals' do
        grid_diagonals = [
          [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5]],
          [[0, 1], [1, 2], [2, 3], [3, 4], [4, 5]],
          [[0, 2], [1, 3], [2, 4], [3, 5]],
          [[0, 5], [1, 4], [2, 3], [3, 2], [4, 1], [5, 0]],
          [[0, 4], [1, 3], [2, 2], [3, 1], [4, 0]],
          [[0, 3], [1, 2], [2, 1], [3, 0]]
        ]
        expect(board_diagonals.diagonals.size).to eq(6)
        expect(board_diagonals.diagonals).to eq(grid_diagonals)
        board_diagonals.diagonals
      end

      it 'returns diagonals greater than 4 elements in size' do
        expect(board_diagonals.diagonals.all? { |arr| arr.size >= 4 }).to be(true)
        board_diagonals.diagonals
      end
    end
  end
end
