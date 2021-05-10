# frozen_string_literal: true

module Mastermind
  class Player
    attr_reader :player_type, :entry, :set_player_type

    def initialize(player_type = '')
      @player_type = player_type
    end

    def set_player_type
      puts 'Would you like to be the Code Breaker or Code Maker?'
      loop do
        puts "'1' for Breaker, '2' for Maker"
        entry = gets.chomp.to_i
        if [1, 2].include?(entry)
          @player_type = entry == 1 ? :breaker : :maker
          break
        else
          puts 'Invalid input. Try again.'
        end
      end
    end
  end
end
