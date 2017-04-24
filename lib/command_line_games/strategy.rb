module CommandLineGames
  class Strategy
    attr_reader :board, :current_symbol

    def initialize(board, current_symbol)
      @board = board
      @current_symbol = current_symbol
    end

    def get_best_move(current_player_symbol)
      raise NotImplementedError
    end

    def opponent(symbol)
      symbol == 'X' ? 'O' : 'X'
    end

    def random_position(available_spaces)
      n = rand(0..available_spaces.count)
      available_spaces[n].to_i
    end

    def self.create(board, current_symbol, strategy_level=nil)
      if strategy_level == "E"
        Strategies::Easy.new(board, current_symbol)
      elsif strategy_level == "H"
        Strategies::Hard.new(board, current_symbol)
      else
        Strategies::Normal.new(board, current_symbol)
      end
    end
  end
end