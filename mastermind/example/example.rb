# frozen_string_literal: true

require_relative '../lib/mastermind'
include Mastermind

loop do
  @game = Mastermind::Game.new
  @game.game_setup
  puts "Play again? * ( 'y' or 'n' )"
  answer = gets.chomp.downcase
  exit! if answer == 'n'
end
