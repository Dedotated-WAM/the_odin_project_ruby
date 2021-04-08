require_relative "spec_helper"
require "minitest/autorun"

module TicTacToe
  # class Cell
  #   attr_accessor :value

  #   def initialize(value = "")
  #     @value = value
  #   end
  # end

  class CellTest < Minitest::Test
    def setup
      @cell = Cell.new
    end

    def test_that_cell_is_initialized_as_empty_string
      assert_equal "", @cell.value
    end

    def test_that_cell_is_initialized_with_value
      cell = Cell.new("X")
      assert_equal "X", cell.value
    end
  end
end
# describe Player do
#   before do
#     @player = Player.new
#   end

#   def test_that_player_raises_exception_when_blank
# end
