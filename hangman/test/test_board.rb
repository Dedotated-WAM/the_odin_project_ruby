require_relative "test_helper"

module Hangman
  class BoardTest < Minitest::Test
    def setup
      @game = Hangman::Game.new
    end

    def test_board_is_initialized_with_default_grid_size
      refute_nil @game.board.grid
      assert_equal 8, @game.board.grid.size
    end
  end
end
