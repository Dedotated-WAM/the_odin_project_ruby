require_relative '../lib/connect_four'

loop do
  game = ConnectFour::Game.new
  game.play_game
end
