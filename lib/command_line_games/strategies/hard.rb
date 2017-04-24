module CommandLineGames
  module Strategies
    class Hard < Strategy
      def get_best_move(current_player_symbol)
        best_score, best_choice = minmax(board, current_player_symbol)
        best_choice.to_i
      end

      def minmax(local_board, current_player_symbol)
        return score(local_board) if local_board.someone_won_or_tied_game?
        scores = {}
        scores.merge!(score_for_each_position(local_board, current_player_symbol, scores))
        best_choice, best_score = best_move(current_player_symbol, scores)
        return best_score, best_choice
      end

      def score_for_each_position(local_board, current_player_symbol, scores)
        local_board.available_positions.each do |position|
          # Copy board so we don't mess up original
          potential_board = local_board.dup
          potential_board.mark_position(position, current_player_symbol)
          scores[position], best_choice = minmax(potential_board, opponent(current_player_symbol))
        end
        scores
      end

      def best_move(piece, scores)
        if piece == current_symbol
          scores.max_by { |_k, v| v }
        else
          scores.min_by { |_k, v| v }
        end
      end

      def score(board)
        if board.winner == current_symbol
          return 10
        elsif board.winner == opponent(current_symbol)
          return -10
        end
        0
      end
    end
  end
end