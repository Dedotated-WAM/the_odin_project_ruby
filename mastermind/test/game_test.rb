# frozen_string_literal: true

require_relative 'test_helper'
require 'minitest/autorun'

module Mastermind
  class GameTest < Minitest::Test
    def test_secret_code_is_initialized_with_code
      @game = Game.new
      assert_equal 4, @game.secret_code.size
    end

    def test_score_guess
      @game = Game.new
      @game.secret_code = %w[r r y y]
      @game.guess = %w[r r b b]
      assert_equal %w[B B],
                   @game.score_guess(@game.guess, @game.secret_code)
      @game.secret_code = %w[r g b y]
      @game.guess = %w[b y g r]
      assert_equal %w[W W W W],
                   @game.score_guess(@game.guess, @game.secret_code)
      @game.guess = %w[w w w w]
      @game.secret_code = %w[r r r r]
      assert_equal %w[],
                   @game.score_guess(@game.guess, @game.secret_code)
      @game.guess = %w[r y r y]
      @game.secret_code = %w[r r y y]
      assert_equal %w[B B W W],
                   @game.score_guess(@game.guess, @game.secret_code)
      @game.guess = %w[p y b r]
      @game.secret_code = %w[y y r r]
      assert_equal %w[B B], @game.score_guess(@game.guess, @game.secret_code)

      @game.guess = %w[w r w b]
      @game.secret_code = %w[y y r r]
      assert_equal %w[W], @game.score_guess(@game.guess, @game.secret_code)

      @game.guess = %w[b b r r]
      @game.secret_code = %w[r y b p]
      assert_equal %w[W W], @game.score_guess(@game.guess, @game.secret_code)

      @game.guess = %w[y b r p]
      @game.secret_code = %w[y y r r]
      assert_equal %w[B B], @game.score_guess(@game.secret_code, @game.guess)

      @game.guess = %w[g b r y]
      @game.secret_code = %w[r y b p]
      assert_equal %w[W W W], @game.score_guess(@game.secret_code, @game.guess)
    end
  end
end
