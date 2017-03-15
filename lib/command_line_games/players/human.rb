module CommandLineGames
  module Players
    class Human < Player
      def initialize(io_interface)
        super(io_interface)
      end

      def choice(next_player)
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

      def choose_name
        @io_interface.choose_player_name
        @name = @io_interface.waiting_for_input
      end

      def choose_strategy(board)
      end
    end
  end

  class HumanBadInputError < RuntimeError
  end
end