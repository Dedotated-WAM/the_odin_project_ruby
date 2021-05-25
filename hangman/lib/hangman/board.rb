# require_relative "../hangman"
module Hangman
  class Board
    attr_reader :grid

    def initialize(input = {})
      @grid = input.fetch(:grid, default_grid)
    end

    @@crossbar = ["  +-----+"]
    @@rope = "|"
    @@head = "O"
    @@torso = "|"
    @@right_leg = "\\"
    @@left_leg = "/"
    @@right_arm = "\\"
    @@left_arm = "/"
    @@floor = ["=========="]

    def default_grid
      [
        [" ", " ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " ", " "]
      ].push(@@floor)
    end

    def score_incorrect_guess(incorrect_guess_count)
      # puts "Incorrect guess count: #{incorrect_guess_count}"
      case incorrect_guess_count
      when 1
        grid[6].insert(-1, "|")
        grid[5].insert(-1, "|")
        grid[4].insert(-1, "|")
        grid[3].insert(-1, "|")
        grid[2].insert(-1, "|")
        grid[1].insert(-1, "|")

      when 2
        grid[0] = @@crossbar
      when 3
        grid[2][2] = @@head
      when 4
        grid[3][2] = @@torso
      when 5
        grid[4][3] = @@right_leg
      when 6
        grid[4][1] = @@left_leg
      when 7
        grid[3][3] = @@right_arm
      when 8
        grid[3][1] = @@left_arm
      when 9
        grid[1][2] = @@rope
      else
        puts "Error in case statement"
      end
    end

    def draw_grid
      @grid.each do |row|
        puts row.join
      end
    end
  end
end
