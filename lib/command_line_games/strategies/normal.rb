module CommandLineGames
  module Strategies
    class Normal < Strategy
      def get_best_move(current_player_symbol)
        return 4 if board.is_position_available?(4)
        best_move = evaluate_best_available_position(board.available_positions, current_player_symbol, board)        
        return best_move if best_move
        random_position(board.available_positions)
      end

      def evaluate_best_available_position(available_spaces, current_player_symbol, board)
        best_move = evaluate_if_can_win(available_spaces, current_player_symbol, board)
        best_move = evaluate_if_can_lose(available_spaces, opponent(current_player_symbol), board) if best_move.nil?
        best_move
      end

      def evaluate_if_can_win(available_spaces, player_symbol, board)
        check_available_positions(available_spaces, player_symbol, board)
      end

      def evaluate_if_can_lose(available_spaces, player_symbol, board)
        check_available_positions(available_spaces, player_symbol, board)
      end

      def check_available_positions(available_spaces, player_symbol, board)
        possibilities = available_spaces.select do |as|
          local_board = board.dup
          check_best_move(as, local_board, player_symbol) 
        end
        possibilities.first
      end

      def check_best_move(current_position, local_board, current_player_symbol)
        local_board.positions[current_position.to_i] = current_player_symbol
        return current_position.to_i if local_board.someone_won?
        nil
      end
    end
  end
end