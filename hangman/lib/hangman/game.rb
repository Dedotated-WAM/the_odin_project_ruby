module Hangman
  class Game
    include Hangman
    attr_reader :player_guesses, :game, :file_name
    attr_accessor :masked_word, :incorrect_guess_count, :board, :word, :save_game, :secret

    WORDS = []
    fd = File.open("5desk.txt")
    fd.each do |line|
      WORDS.push(line.strip)
    end
    fd.close

    def initialize(board = Board.new)
      @board = board
      @word = WORDS.sample(1).join("").downcase
      @secret = @word.split("")
      @masked_word = Array.new(@secret.size, " _ ")
      @round_number = 0
      @player_letter = nil
      @player_guesses = []
      @incorrect_guess_count = 0
    end

    def solicit_player_letter
      puts "Enter a letter (or enter 'save' to save current game progress and exit):"
      response = gets.chomp.downcase
      letter = nil

      while letter.nil?
        if response.match?(/save/)
          Hangman.save_game(self)
        elsif response.length == 1 && response.match?(/[a-z]/) && !@player_guesses.include?(response)
          letter = response
        else
          if @player_guesses.include?(response)
            puts "Letter was previously guessed.  Please choose a different letter."
          else
            puts "Invalid entry.  Please try again."
          end
          response = gets.chomp.downcase
        end
      end
      @player_letter = letter
      @player_guesses.push(@player_letter)
    end

    def score_player_letter
      if secret.include?(@player_letter)
        secret.each_with_index do |letter, index|
          masked_word[index] = @player_letter if @player_letter == letter
        end
      else
        @incorrect_guess_count += 1
        board.score_incorrect_guess(incorrect_guess_count)
      end
    end

    def display_round_info
      puts "Round #: #{@round_number}"
      puts "Prior guesses: #{@player_guesses.sort}"
      puts @masked_word.join(" ")
    end

    def winner?
      true if secret == masked_word
    end

    def play_again?
      puts "Would you like to play again ('y' or 'n'?)"
      response = gets.chomp
      until response.include?("y") || response.include?("n")
        puts "Invalid entry. 'y' or 'n'?"
        play_again?
      end
      if response == "y"
        @game = Game.new
        @game.play_game
      else
        puts "Goodbye."
        exit
      end
    end

    def play_game
      if @round_number.zero?
        puts " ------ Welcome to Hangman ------ "
        puts "Enter 'load' to load saved game file or press enter to continue:"
        response = gets.chomp
        Hangman.load_game if response == "load"
      else
        puts "Welcome back"
        display_round_info
      end
      @board.draw_grid
      while incorrect_guess_count < 9
        display_round_info
        solicit_player_letter
        puts "Letter: #{@player_letter}"
        score_player_letter
        @board.draw_grid
        @round_number += 1
        if winner?
          puts "Nice work!  You were able to save your neck from the rope by guessing the secret word: \"#{secret.join}\"."
          play_again?
        end
      end
      if @incorrect_guess_count == 9
        puts masked_word.join(" ")
        puts secret.join(" ")
        puts ""
        puts "Game over. You hung from the gallows."
        play_again?
      end
    end
  end
end
