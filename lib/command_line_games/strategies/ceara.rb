module CommandLineGames
  module Strategies
    class Ceara < Strategy

      def initialize attributes = {}
        super attributes
        @moves = [[0, 8], [2, 6]].shuffle!.map(&:shuffle).flatten!
      end

      def get_best_move(current_player_symbol)
        move = evaluate_best_available_position(current_player_symbol)
        move = next_move unless move
        move = board.available_positions.first.to_i unless move
        move
      end

      def next_move
        move = @moves.pop
        if board.available_positions.include?(move.to_s)
          move
        elsif move
          next_move
        end
      end

      def evaluate_best_available_position(current_player_symbol)
        best_move = evaluate_if_can_win(board.available_positions, current_player_symbol, board)
        best_move = evaluate_if_can_lose(board.available_positions, opponent(current_player_symbol), board) if best_move.nil?
        best_move
      end

      def evaluate_if_can_win(available_positions, player_symbol, board)
        check_available_positions(available_positions, player_symbol, board)
      end

      def evaluate_if_can_lose(available_positions, player_symbol, board)
        check_available_positions(available_positions, player_symbol, board)
      end

      def check_available_positions(available_positions, player_symbol, board)
        possibilities = available_positions.select do |as|
          check_best_move(as, board, player_symbol)
        end
        possibilities.first
      end

      def check_best_move(current_position, board, current_player_symbol)
        local_board = board.mark_position(current_position.to_i, current_player_symbol)
        return current_position.to_i if local_board.someone_won?
        nil
      end
    end
  end
end