module CommandLineGames
  class HumanPlayer < Player
    def initialize(io_interface, game)
      super(io_interface, game)
    end

    def choice(next_player, board)
      io_interface.show_input_options
      input = io_interface.waiting_for_input
      fail(HumanBadInputError, 'Bad Input') if bad_input?(input)
      input
    end

    def choose_symbol(symbol_list)
      @io_interface.choose_player_symbol
      @symbol = @io_interface.waiting_for_input
      fail(HumanBadInputError, 'Bad Input') unless symbol_list.include?(symbol.upcase)
      symbol
    end
  end

  class HumanBadInputError < RuntimeError
  end
end