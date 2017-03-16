module CommandLineGames
  class Strategy
    attr_reader :board, :current_symbol

    def initialize(board, current_symbol)
      @board = board
      @current_symbol = current_symbol
    end

    def get_best_move(current_player_symbol)
      return 4 if board.is_position_available?(4)      
      available_spaces = board.availabel_positions
      n = rand(0..available_spaces.count)
      available_spaces[n].to_i
    end

    def opponent(symbol)
        symbol == 'X' ? 'O' : 'X'
      end

    def self.create(board, current_symbol, strategy_level=nil)
      if strategy_level == "E"
        Strategies::Easy.new(board, current_symbol)
      elsif strategy_level == "H"
        Strategies::Hard.new(board, current_symbol)
      else
        Strategies::Medium.new(board, current_symbol)
      end
    end
  end
end