require_relative "spec_helper"
require "minitest/autorun"

module TicTacToe
  class PlayerTest < Minitest::Test
    def test_that_player_raises_exception_when_invalid_hash
      assert_raises(KeyError) { Player.new({}) }
    end

    def test_that_player_creates_player_without_error_with_valid_hash
      assert_silent { Player.new({ color: "X", name: "Someone" }) }
    end

    def test_that_player_returns_the_color
      input = { color: "X", name: "Someone" }
      player = Player.new(input)
      assert_equal "X", player.color
    end

    def test_that_player_returns_the_name
      input = { color: "X", name: "Someone" }
      player = Player.new(input)
      assert_equal "Someone", player.name
    end
  end
end
