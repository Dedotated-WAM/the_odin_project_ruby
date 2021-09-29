module ConnectFour
  class Game
    attr_reader :board, :players, :current_player, :other_player, :player_one, :player_two, :current_move

    def initialize(minimum = 1, maximum = 7, current_move = nil)
      @minimum = minimum
      @maximum = maximum
      @current_move = current_move
      @round_number = 0
      @player_one = Player.new("Player One", BLACK_CIRCLE)
      @player_two = Player.new("Player Two", RED_CIRCLE)
      @players = [@player_one, @player_two]
      @current_player, @other_player = @players.shuffle
      @board = Board.new
    end

    def valid_column?(user_input)
      return true if user_input.to_i.between?(@minimum, @maximum)

      # && user_input.match(/[#{@minimum}-#{@maximum}]/)

      false
    end

    def switch_players
      @current_player, @other_player = @other_player, @current_player
    end

    def solicit_move
      @current_move = nil

      until @current_move
        puts "#{@current_player.name}: Enter a column number between #{@minimum} and #{@maximum} to drop your chip."
        user_input = gets.chomp

        unless valid_column?(user_input)
          puts "Error!  Input must be a number between #{@minimum} and #{@maximum}"
          redo
        end

        if board.column_full?(user_input.to_i - 1)
          puts "Column '#{user_input}' is full. Please make a different selection."
          redo
        end

        return @current_move = user_input.to_i - 1
      end
    end

    def play_again?
      loop do
        puts "Play again? (y/n)"
        input = gets.chomp
        if input.downcase.split("").include?("y")
          return true
        elsif input.downcase.split("").include?("n")
          return false
        else
          puts "Invalid entry"
          redo
        end
      end
    end

    def play_game
      loop do
        board.display_grid
        solicit_move
        board.place_symbol(@current_move, @current_player)
        if board.winner?
          board.display_grid
          puts "#{@current_player.name} Wins!"
          puts
          return nil if play_again?

          begin
            puts "Exiting Program"
            puts "Thanks for playing! Goodbye."
            exit!
          rescue SystemExit
            return nil
          end
        end
        switch_players
      end
    end
  end
end
