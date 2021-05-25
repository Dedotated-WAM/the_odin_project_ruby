require_relative "test_helper"

module Hangman
  class TestGame < Minitest::Test
    def test_game_is_initialized_with_word
      game = Hangman::Game.new
      refute_nil game.word
    end

    def test_game_over
      game = Hangman::Game.new
      game.word = "testvalue"
      game.secret = "testvalue".split("")
      assert %w[t e s t v a l u e], game.secret
      game.masked_word = "testvalue".split("")
      assert_equal true, game.winner?
    end
  end
end
