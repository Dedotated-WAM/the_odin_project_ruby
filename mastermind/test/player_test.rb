# frozen_string_literal: true

require_relative 'test_helper'

module Mastermind
  class PlayerTest < Minitest::Test
    def test_set_player_initialized_to_empty_string
      @game = Game.new
      assert_equal '', @game.player.player_type
    end
  end
end
