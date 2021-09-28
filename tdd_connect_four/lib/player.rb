# p require_relative 'connect_four'

module ConnectFour
  class Player
    attr_reader :name, :symbol

    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end
  end
end
