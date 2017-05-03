module CommandLineGames
  class Strategy
    attr_reader :board, :current_symbol

    def initialize(current_symbol)
      @current_symbol = current_symbol
    end

    def update_board(board)
      @board = board
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

    def self.create(current_symbol, strategy_level=nil)
      if strategy_level == "E"
        Strategies::Easy.new(current_symbol)
      elsif strategy_level == "H"
        Strategies::Hard.new(current_symbol)
      elsif strategy_level == "C"
        Strategies::Ceara.new(current_symbol)
      else
        Strategies::Normal.new(current_symbol)
      end
    end
  end
end