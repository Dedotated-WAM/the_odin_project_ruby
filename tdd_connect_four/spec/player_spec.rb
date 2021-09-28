require_relative '../lib/connect_four'

describe ConnectFour::Player do
  subject(:player) { described_class.new('Player One', black_circle) }

  describe '#set_player_symbol' do
    let(:black_circle) { "\u26AB".encode('utf-8') }
    let(:red_circle) { "\u{1F534}".encode('utf-8') }
    let(:game) { ConnectFour::Game.new }

    context 'when players are initialized' do
      it 'sets player_one symbol to a black_circle' do
        expect(game.player_one.symbol).to eq(black_circle)
      end

      it 'sets player_two symbol to a red_circle' do
        expect(game.player_two.symbol).to eq(red_circle)
      end
    end
  end
end
