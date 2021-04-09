require_relative "spec_helper"
require "minitest/autorun"

module TicTacToe
  class BoardTest < Minitest::Test
    def test_board_initializes_with_a_grid
      assert_silent { Board.new(grid: "grid") }
    end

    def test_board_sets_grid_with_three_rows_by_default
      @board = Board.new
      assert_equal 3, @board.grid.size
    end

    def test_board_returns_grid
      @board = Board.new(grid: "foo")
      assert_equal "foo", @board.grid
    end

    def test_board_returns_cell_based_on_xy_coordinate
      @grid = [["", "", ""],
               ["", "", "foo"],
               ["", "", ""]]
      @board = Board.new(grid: @grid)
      assert_equal "foo", @board.grid[1][2]
    end

    def test_board_updates_the_value_of_cell_at_xy
      @cat = Struct.new(:value)
      @grid = [[@cat.new("cool"), "", ""], ["", "", ""], ["", "", ""]]
      @board = Board.new(grid: @grid)
      @board.set_cell(0, 0, "meow")
      assert_equal "meow", @board.get_cell(0, 0).value
    end

    def test_board_determines_winner
      @board = Board.new
      @board.stub :winner?, true do
        assert_equal :winner, @board.game_over
      end
    end

    def test_board_determines_a_draw
      @board = Board.new
      @board.stub :winner?, false do
        @board.stub :draw?, true do
          assert :draw, @board.game_over
        end
      end
    end

    def test_board_returns_false_if_winner_or_draw_false
      @board = Board.new
      @board.stub :winner?, false do
        @board.stub :draw?, false do
          assert_equal false, @board.game_over
        end
      end
    end

    TestCell = Struct.new(:value)
    def x_cell
      TestCell.new("X")
    end

    def y_cell
      TestCell.new("Y")
    end

    def empty
      TestCell.new
    end

    def test_winner_is_returned_if_winner_is_true
      @board = Board.new
      @board.stub :winner?, true do
        assert_equal :winner, @board.game_over
      end
    end

    def test_draw_is_returned_if_winner_false_and_draw_true
      @board = Board.new
      @board.stub :winner?, false do
        @board.stub :draw?, true do
          assert_equal :draw, @board.game_over
        end
      end
    end

    def test_false_is_returned_if_winner_false_and_draw_false
      @board = Board.new
      @board.stub :winner?, false do
        @board.stub :draw?, false do
          assert_equal false, @board.game_over
        end
      end
    end

    def test_winner_is_returned_when_row_has_all_same_values
      grid = [
        [x_cell, x_cell, x_cell],
        [y_cell, x_cell, y_cell],
        [y_cell, y_cell, empty]
      ]
      @board = Board.new(grid: grid)
      assert_equal :winner, @board.game_over
    end

    def test_winner_is_returned_when_column_has_all_same_values
      @grid = [
        [x_cell, x_cell, empty],
        [y_cell, x_cell, y_cell],
        [y_cell, x_cell, empty]
      ]
      @board = Board.new(grid: @grid)
      assert_equal :winner, @board.game_over
    end

    def test_winner_is_returned_when_diagonals_all_the_same_values
      @grid = [
        [x_cell, empty, y_cell],
        [y_cell, x_cell, empty],
        [y_cell, y_cell, x_cell]
      ]
      @board = Board.new(grid: @grid)
      assert_equal :winner, @board.game_over
    end

    def test_draw_is_returned_when_all_board_spaces_are_occupied
      @grid = [
        [x_cell, x_cell, y_cell],
        [y_cell, y_cell, x_cell],
        [x_cell, y_cell, y_cell]
      ]
      @board = Board.new(grid: @grid)
      assert_equal :draw, @board.game_over
    end

    def test_false_is_returned_if_no_winner_or_draw
      @grid = [
        [x_cell, empty, empty],
        [y_cell, empty, empty],
        [x_cell, empty, empty]
      ]
      @board = Board.new(grid: @grid)
      assert_equal false, @board.game_over
    end
  end
end
