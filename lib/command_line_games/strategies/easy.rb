module CommandLineGames
  module Strategies
    class Easy < Strategy
      def get_best_move(current_player_symbol)
        random_position(board.available_positions)
      end
    end
  end
end