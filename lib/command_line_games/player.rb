module CommandLineGames  
  class Player

    attr_reader :io_interface
    attr_accessor :symbol, :name, :strategy

    def initialize(io_interface)
      @io_interface = io_interface
    end

    def choose_symbol(symbol_list)
      @symbol = symbol_list.first
    end

    def choice
      strategy.get_best_move(symbol)
    end

    def choose_name
      @name = "Computer"
    end

    def choose_strategy(board)
      @io_interface.choose_player_strategy
      strategy_type = @io_interface.waiting_for_input
      @strategy = Strategy.create(board, symbol, strategy_type)
    end
    
    def bad_input?(input)
      input.match(/[^0-8]/)
    end

    def self.create_player(type, io_interface)
      (type.upcase == "H" ? Players::Human.new(io_interface) : Players::Computer.new(io_interface))
    end
  end
end