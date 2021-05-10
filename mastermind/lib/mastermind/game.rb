# frozen_string_literal: true

module Mastermind
  class Game
    attr_reader :board, :round_number, :player, :permutations
    attr_accessor :secret_code, :guess

    COLORS = {
      'r' => 'red',
      'y' => 'yellow',
      'b' => 'blue',
      'p' => 'purple',
      'g' => 'green',
      'w' => 'white',
      'k' => 'black',
      'o' => 'orange'
    }.freeze

    PERMUTATIONS = COLORS.map { |key, _value| key }.repeated_permutation(4).to_a

    def initialize(board = Board.new, player = Player.new)
      @board = board
      @secret_code = generate_random_secret_code
      @round_number = 0
      @player = player
      @guess = []
    end

    def generate_random_secret_code
      return secret_code unless @secret_code.nil?

      @secret_code = []

      4.times do
        secret_code.push(COLORS.to_a.sample(1)[0])
      end
      secret_code.map! { |color| color[0] }
    end

    def set_maker_code
      p 'Colors:'
      p COLORS
      puts ''
      puts 'Set the secret code'
      # rubocop: disable all
      loop do
        entry = gets.chomp.downcase.split("")
        if entry.size == 4 && entry.all? {|color| COLORS.each { |key, _value| key.include?(color)} }
          @secret_code = entry
          break
        else
          puts "Invalid entry.  Try again"
        # rubocop: enable all
        end
      end
    end

    def winner?
      return true if @guess == @secret_code
    end

    def store_player_guess
      # rubocop: disable all
      loop do 
        entry = gets.chomp.downcase.split("")
        if entry.size == 4 && entry.all? {|color| COLORS.keys.include?(color)}
          @guess = entry
          store_guess          
          break
      # rubocop: enable all
        else
          puts 'Invalid entry. Please try again.'
        end
      end
    end

    def store_guess
      board.grid[round_number] = @guess
    end

    def score_guess(guess, code)
      result = []
      guess_dup = guess.dup
      code_dup = code.dup

      guess.each_with_index do |guess_letter, guess_index|
        guess_dup[guess_index] = 'x' unless code.include?(guess_letter)
        next unless guess_letter == code[guess_index]

        result.push('B')
        guess_dup[guess_index] = 'x'
        code_dup[guess_index] = 'x'
      end

      guess_dup.each do |letter|
        next unless code_dup.include?(letter) && letter != 'x'

        result.push('W')
        guess_dup[guess_dup.index(letter)] = 'x'
        code_dup[code_dup.index(letter)] = 'x'
      end

      result.sort
    end

    def store_pegs(guess = @guess)
      score = score_guess(guess, secret_code)

      board.pegs[round_number] = score
    end

    def game_setup
      puts ''
      puts 'Welcome to Mastermind'
      player.set_player_type
      if player.player_type == :breaker
        play
      else
        set_maker_code
        computer_player
      end
    end

    def play
      while @round_number <= 12
        puts "Round Number: #{round_number + 1}"
        puts '| ? | ? | ? | ? |'
        puts ''
        puts ''
        board.formatted_grid
        # puts "secret_code: #{secret_code}"
        puts COLORS
        puts ''
        puts 'Break the code:'
        store_player_guess
        p "guess = #{guess.join(' ')}"
        score_guess(@guess, @secret_code)
        store_pegs
        if winner?
          puts 'Game Over'
          puts 'Secret_code has been broken!'
          puts '-----------------   '
          puts "          #{@secret_code.map { |color| color[0] }.join(' ')}"
          puts '-----------------   '
          board.formatted_grid
          break
        else
          @round_number += 1
        end
      end
      puts 'Game Over'
      puts 'You were unable to break the code.'
      puts '-----------------   '
      puts "    #{@secret_code.map { |color| color[0] }.join(' ')}"
      puts '-----------------   '
    end

    def computer_player
      prior_guesses = []
      puts 'Computer is the code breaker'
      permutations = PERMUTATIONS.dup
      while round_number <= 12
        puts "Round Number: #{round_number + 1}"
        if @round_number.zero?
          @guess = %w[b b r r]
          permutations.delete(@guess)
        else

          puts 'Computer is thinking...'

          permutations.delete_if do |element|
            score_guess(element,
                        guess) != score_guess(
                          guess, secret_code
                        )
          end

          possible_guesses = PERMUTATIONS.dup

          prior_guesses.each do |prior_guess|
            possible_guesses.delete(prior_guess)
          end

          score_set = {}

          permutations.each do |permutation|
            permutation_scores = []
            possible_guesses.each do |possible_guess|
              permutation_scores.push(score_guess(permutation,
                                                  possible_guess))
            end

            permutation_scores = permutation_scores.delete_if do |value|
              value == []
            end

            score = permutation_scores.tally.values.sum

            score_set[permutation] = score
          end

          @guess = score_set.key(score_set.values.max)

        end

        prior_guesses.push(@guess)

        if winner?
          puts ''
          puts 'Game Over'
          puts 'Secret_code has been broken!'
          puts '-----------------   '
          puts "          #{@secret_code.map { |color| color[0] }.join(' ')}"
          puts '-----------------   '
          store_guess
          store_pegs
          board.formatted_grid
          break
        else
          store_guess
          store_pegs
          board.formatted_grid
          @round_number += 1
          sleep(1) if round_number > 3
        end
        if round_number > 12
          puts 'Game Over. The computer was unable to break your code!'
          break
        end
      end
    end
  end
end
