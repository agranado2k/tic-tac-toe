module CommandLineGames
  module Strategies
    class Easy < Strategy
      def get_best_move(current_player_symbol)
        return 4 if board.is_position_available?(4)      
        available_spaces = board.available_positions
        n = rand(0..available_spaces.count)
        available_spaces[n].to_i
      end
    end
  end
end