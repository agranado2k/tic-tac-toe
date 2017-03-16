module CommandLineGames
  module Players
    class Computer < Player
      def initialize(io_interface)
        super(io_interface)
      end

      def choose_symbol(symbol_list)
        @symbol = symbol_list.first
      end

      def choose_name
        @name = "Computer"
      end
    end
  end
end