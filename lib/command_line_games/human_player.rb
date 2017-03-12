module CommandLineGames
  class HumanPlayer < Player
    def initialize(symbol, io_interface, game)
      super(symbol, io_interface, game)
    end

    def choice(next_player, board)
      input = io_interface.waiting_for_input
      fail(HumanBadInputError, 'Bad Input') if bad_input?(input)
      input
    end
  end

  class HumanBadInputError < RuntimeError
  end
end