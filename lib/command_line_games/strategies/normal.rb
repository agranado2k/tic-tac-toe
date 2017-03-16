module CommandLineGames
  module Strategies
    class Medium < Strategy
      def get_best_move(current_player_symbol)
        return 4 if board.is_position_available?(4)
        best_move = try_to_evaluate_each_available_board_position_if_him_can_win_or_loss(board.available_positions, current_player_symbol, board)        
        return best_move if best_move
        random_position(board.available_positions)
      end

      def try_to_evaluate_each_available_board_position_if_him_can_win_or_loss(available_spaces, current_player_symbol, board)
        best_move = evaluate_each_available_board_position_if_him_can_win(available_spaces, current_player_symbol, board)
        best_move = evaluate_each_available_board_position_if_him_can_loss(available_spaces, opponent(current_player_symbol), board) if best_move.nil?
        best_move
      end

      def evaluate_each_available_board_position_if_him_can_win(available_spaces, player_symbol, board)
        evaluate_each_available_board_position(available_spaces, player_symbol, board)
      end

      def evaluate_each_available_board_position_if_him_can_loss(available_spaces, player_symbol, board)
        evaluate_each_available_board_position(available_spaces, player_symbol, board)
      end

      def evaluate_each_available_board_position(available_spaces, player_symbol, board)
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