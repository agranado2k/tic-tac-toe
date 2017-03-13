module CommandLineGames  
  class Player

    attr_accessor :symbol, :name
    attr_reader :io_interface, :game

    def initialize(io_interface, game)
      @io_interface = io_interface
      @game = game
    end

    def choose_player_symbol
      "X"
    end

    def choice(next_player, board)
      fail("Have to implement")
    end

    def choose_name
      @name = "Player"
    end
    
    def bad_input?(input)
      input.match(/[^0-8]/)
    end

    def self.create_player(type, io_interface, game)
      (type.upcase == "H" ? HumanPlayer.new(io_interface, game) : ComputerPlayer.new(io_interface, game))
    end
  end
end