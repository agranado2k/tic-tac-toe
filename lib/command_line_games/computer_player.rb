module CommandLineGames
  class ComputerPlayer < Player
    def initialize(symbol, io_interface, game)
      super(symbol, io_interface, game)
    end

    def player_choice(next_player, board)
      return 4 if board.is_position_available?(4)
      game.get_best_move(board.positions, symbol, next_player.symbol)
    end
  end
end