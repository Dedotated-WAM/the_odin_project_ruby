module TicTacToe
  # Provides the mechanics for game play
  class Game
    attr_reader :players, :board, :current_player, :other_player

    def initialize(players, board = Board.new)
      @players = players
      @board = board
      @current_player, @other_player = players.shuffle
    end

    def switch_players
      @current_player, @other_player = @other_player, @current_player
    end

    def solicit_move
      "#{current_player.name}: Enter a number between 1 and 9 to mark your spot"
    end

    def get_move(human_move = gets.chomp)
      human_move_to_coordinate(human_move)
    end

    def game_over_message
      return "#{current_player.name} won!" if board.game_over == :winner
      return "The game ended in a tie." if board.game_over == :draw
    end

    def play
      puts "#{current_player.name} has been randomly selected as the first player."
      loop do
        board.formatted_grid
        puts ""
        puts solicit_move
        x, y = get_move
        begin
          board.get_cell(x, y)
        rescue TypeError
          puts "Invalid entry. Please try again."
          redo
        else
          if board.get_cell(x, y).value == ""
            board.set_cell(x, y, current_player.color)
          else
            p "Space is occupied, please make a different selection."
          end
        end
        if board.game_over
          puts game_over_message
          board.formatted_grid
          break
        else
          switch_players
        end
      end
    end

    private

    def human_move_to_coordinate(human_move)
      mapping = {
        "1" => [0, 0],
        "2" => [1, 0],
        "3" => [2, 0],
        "4" => [0, 1],
        "5" => [1, 1],
        "6" => [2, 1],
        "7" => [0, 2],
        "8" => [1, 2],
        "9" => [2, 2]
      }
      mapping[human_move]
    end
  end
end
