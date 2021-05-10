# frozen_string_literal: true

require_relative 'test_helper'

module Mastermind
  class BoardTest < Minitest::Test
    attr_reader :grid

    def setup
      @grid = [
        ['hello', '', '', ''],
        ['', '', '', ''],
        ['', '', '', ''],
        ['', '', '', ''],
        ['', '', '', ''],
        ['', '', '', ''],
        ['', '', '', ''],
        ['', '', '', ''],
        ['', '', '', ''],
        ['', '', '', ''],
        ['', '', '', ''],
        ['', '', '', '']
      ]
    end

    def test_board_initializes_with_a_grid
      assert_silent { Board.new(grid: 'grid') }
    end

    def test_board_is_initialized_with_12_rows_by_default
      @board = Board.new
      assert_equal 12, @board.grid.size
    end

    def test_board_returns_grid
      @board = Board.new(grid: 'foo')
      assert_equal 'foo', @board.grid
    end

    def test_get_cell
      @board = Board.new
      @board.grid[0] = 'foob'.split
      assert_equal 'foob', @board.get_cell(0).join
    end

    def test_store_guess
      @game = Game.new
      @game.guess = %w[g r b k]
      @game.stub :round_number, 1 do
        @game.store_guess
      end
      assert_equal %w[g r b k], @game.board.grid[1]
    end
  end
end
