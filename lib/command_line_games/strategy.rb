module CommandLineGames
  class Strategy
    attr_reader :board

    def initialize(board)
      @board = board
    end

    def get_best_move(current_player_symbol, next_player_symbol, depth = 0, best_score = {})
      return 4 if board.is_position_available?(4)      
      available_spaces = board.availabel_positions
      n = rand(0..available_spaces.count)
      available_spaces[n].to_i
    end

    def self.create(board, strategy_level=nil)
      if strategy_level == "E"
        Strategies::Easy.new(board)
      elsif strategy_level == "H"
        Strategies::Hard.new(board)
      else
        Strategies::Normal.new(board)
      end
    end
  end
end