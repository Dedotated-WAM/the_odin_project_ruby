require_relative "spec_helper"
require "minitest/autorun"
require "minitest/stub_any_instance"

module TicTacToe
  class GameTest < Minitest::Test
    attr_reader :bob, :frank

    def setup
      @bob = Player.new({ color: "X", name: "bob" })
      @frank = Player.new({ color: "O", name: "frank" })
    end

    def test_game_randomly_selects_a_current_player
      Array.stub_any_instance(:shuffle, [@frank, @bob]) do
        @game = Game.new([@bob, @frank])
        assert @frank, @game.current_player
      end
    end

    def test_game_selects_the_other_player
      Array.stub_any_instance(:shuffle, [@frank, @bob]) do
        @game = Game.new([@bob, @frank])
        assert @bob, @game.other_player
      end
    end

    def test_solicit_move_asks_player_to_make_a_move
      @game = Game.new([@bob, @frank])
      @game.stub :current_player, @bob do
        assert "@bob: Enter a number between 1 and 9 to mark your spot",
               @game.solicit_move
      end
    end

    def test_switch_players_sets_current_player_to_other_player
      @game = Game.new([@bob, @frank])
      @other_player = @game.other_player
      @game.switch_players
      assert_equal @other_player, @game.current_player
    end

    def test_switch_players_sets_other_player_to_current_player
      @game = Game.new([@bob, @frank])
      @current_player = @game.current_player
      @game.switch_players
      assert_equal @current_player, @game.other_player
    end

    def test_converts_human_move_of_one
      @game = Game.new([@bob, @frank])
      assert_equal [0, 0], @game.get_move("1")
    end

    def test_converts_human_move_of_seven
      @game = Game.new([@bob, @frank])
      assert_equal [0, 2], @game.get_move("7")
    end

    def test_returns_player_name_won_message_if_winner
      @game = Game.new([@bob, @frank])
      @game.stub :current_player, @bob do
        @game.board.stub :game_over, :winner do
          assert "@bob won!", @game.game_over_message
        end
      end
    end

    def test_returns_draw_message
      @game = Game.new([@bob, @frank])
      @game.stub :current_player, @bob do
        @game.board.stub :game_over, :draw do
          assert_equal "The game ended in a tie.", @game.game_over_message
        end
      end
    end
  end
end
