module TicTacToe
  # Cells which comprise the board
  class Cell
    attr_accessor :value

    def initialize(value = "")
      @value = value
    end
  end
end
