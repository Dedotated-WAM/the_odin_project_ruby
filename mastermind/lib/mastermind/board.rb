# frozen_string_literal: true

module Mastermind
  class Board
    attr_reader :grid, :pegs

    def initialize(input = {})
      @grid = input.fetch(:grid, default_grid)
      @pegs = input.fetch(:pegs, default_pegs)
    end

    def get_cell(index)
      grid[index]
    end

    def formatted_grid
      puts ' score  |  guess '
      puts '-------------------'
      i = 11
      while i >= 0
        peg_text = pegs[i].dup

        peg_text.push('_') until peg_text.size == 4

        grid_text = grid[i].join(' ')
        peg_text = peg_text.shuffle.join(' ')

        puts "#{peg_text} | #{grid_text}"
        i -= 1
      end
    end

    private

    def default_grid
      Array.new(12) { [] }
    end

    def default_pegs
      Array.new(12) { [] }
    end
  end
end
