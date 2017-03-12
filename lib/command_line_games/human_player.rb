module CommandLineGames
  class HumanPlayer < Player
    def initialize(symbol, io_interface, game)
      super(symbol, io_interface, game)
    end

    def player_choice(next_player, board)
      input = io_interface.waiting_for_input
      fail('Bad Input') if bad_input?(input)
      input
    end
  end
end