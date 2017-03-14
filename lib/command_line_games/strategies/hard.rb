module CommandLineGames
  module Strategies
    class Hard < Strategy
      def get_best_move(current_player_symbol, next_player_symbol, depth = 0, best_score = {})
        return 4 if board.is_position_available?(4)      
        available_spaces = board.availabel_positions
        n = rand(0..available_spaces.count)
        available_spaces[n].to_i
      end
    end
  end
end