module CommandLineGames
  class GameStrategy
    attr_reader :board

    def initialize(board)
      @board = board
    end

    def get_best_move(current_player_symbol, next_player_symbol, depth = 0, best_score = {})
      return 4 if board.is_position_available?(4)
      available_spaces = board.availabel_positions
      best_move = nil

      ### try to evaluate each available board position if him can win or loss
      available_spaces.each do |as|
        board.positions[as.to_i] = current_player_symbol
        if board.someone_won?
          best_move = as.to_i
          board.positions[as.to_i] = as
          return best_move
        else
          board.positions[as.to_i] = next_player_symbol
          if board.someone_won?
            best_move = as.to_i
            board.positions[as.to_i] = as
            return best_move
          else
            board.positions[as.to_i] = as
          end
        end
      end
      
      ### if found a best move use it
      if best_move
        return best_move
      else
        ### get random position
        n = rand(0..available_spaces.count)
        return available_spaces[n].to_i
      end
    end
  end
end