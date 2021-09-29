module ConnectFour
  class Board
    attr_accessor :grid

    def initialize
      @grid ||= default_grid
    end

    def default_grid
      rows = 6
      columns = 7
      Array.new(columns) { Array.new(rows, "_") }
    end

    def display_grid(empty_space_symbol = ConnectFour::WHITE_CIRCLE)
      puts "~ Connect Four ~"
      puts " 1 2 3 4 5 6 7"
      result = @grid.map { |arr| arr.map { |el| el == "_" ? empty_space_symbol : el } }
      result.transpose.each { |arr| puts arr.join }
    end

    # rubocop: disable all 
    def display_raw_grid
      c = 0
      result = []
      while c < grid.size
        r = 0
        while r < grid[0].size do
          result << [c,r]
          r += 1
        end
        c += 1
      end
      p result.transpose
    end
    # rubocop: enable all

    def place_symbol(current_move, current_player)
      target = grid[current_move].index { |space| space != "_" }

      if target.nil?
        grid[current_move][-1] = current_player.symbol
      else
        grid[current_move][target - 1] = current_player.symbol
      end
    end

    def column_full?(column_num)
      return true if grid[column_num].none? { |element| element == "_" }

      false
    end

    def winner?
      win = false
      grid.each do |col|
        column = col.join("")
        win = true if column.match(/#{RED_CIRCLE * 4}/) || column.match(/#{BLACK_CIRCLE * 4}/)
      end

      grid.transpose.each do |r|
        row = r.join("")
        win = true if row.match(/#{RED_CIRCLE * 4}/) || row.match(/#{BLACK_CIRCLE * 4}/)
      end

      diagonals.each do |diag|
        result = []
        diag.each do |r, c|
          result << grid[r][c]
        end
        result = result.join("")
        win = true if result.match(/#{RED_CIRCLE * 4}/) || result.match(/#{BLACK_CIRCLE * 4}/)
      end
      win
    end

    def diagonals
      right_to_left_diagonals = []
      (0..grid[0].size - 1).each do |c|
        temp = []
        (0..grid.size - 1).each do |r|
          temp << [r, c]
          c += 1
          break if c >= grid[0].size
        end
        right_to_left_diagonals << temp
      end

      left_to_right_diagonals = []
      (grid[0].size - 1).downto(0).each do |c|
        temp = []
        (0..grid.size - 1).each do |r|
          temp << [r, c]
          c -= 1
          break if c < 0
        end
        left_to_right_diagonals << temp
      end

      right_to_left_diagonals.select { |diag| diag.size >= 4 } + left_to_right_diagonals.select do |diag|
        diag.size >= 4
      end
    end
  end
end
