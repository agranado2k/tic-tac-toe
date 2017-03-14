module CommandLineGames
  class ComputerPlayer < Player
    def initialize(io_interface, game)
      super(io_interface, game)
    end

    def choice(next_player, board)
      return 4 if board.is_position_available?(4)
      game.get_best_move(board, board.positions, symbol, next_player.symbol)
    end

    def choose_symbol(symbol_list)
      @symbol = symbol_list.first
    end
  end
end