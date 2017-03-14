module CommandLineGames
  class ComputerPlayer < Player
    def initialize(io_interface)
      super(io_interface)
    end

    def choice(next_player)
      strategy.get_best_move(symbol, next_player.symbol)
    end

    def choose_symbol(symbol_list)
      @symbol = symbol_list.first
    end
  end
end