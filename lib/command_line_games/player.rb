module CommandLineGames  
  class Player

    attr_reader :symbol, :io_interface, :game

    def initialize(symbol, io_interface, game)
      @symbol = symbol
      @io_interface = io_interface
      @game = game
    end
    
    def bad_input?(input)
      input.match(/[^0-8]/)
    end
  end
end