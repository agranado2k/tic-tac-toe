module CommandLineGames  
  class Player

    attr_reader :io_interface
    attr_accessor :symbol, :name, :strategy

    def initialize(io_interface)
      @io_interface = io_interface
    end

    def choose_player_symbol
      "X"
    end

    def choice(next_player)
      fail("Have to implement")
    end

    def choose_name
      @name = "Player"
    end
    
    def bad_input?(input)
      input.match(/[^0-8]/)
    end

    def self.create_player(type, io_interface)
      (type.upcase == "H" ? HumanPlayer.new(io_interface) : ComputerPlayer.new(io_interface))
    end
  end
end