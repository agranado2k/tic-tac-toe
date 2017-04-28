module CommandLineGames  
  class Board
    attr_reader :positions, :game_input_output

    SYMBOL_X = "X"
    SYMBOL_O = "O"

    WINNING_COMBINATIONS = [
      # Horizontal wins:
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      # Vertical wins:
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      # Diagonal wins:
      [0, 4, 8], [2, 4, 6]
    ]

    def initialize(board)
      @positions = board
      @positions.freeze
    end
    
    def mark_position(spot, mark)
      new_positions = positions.dup
      new_positions[spot] = mark
      Board.new(new_positions)
    end

    def available_positions
      positions.select.with_index{|position, index| is_position_available?(index)}.map(&:to_i)
    end

    def is_position_available?(spot)
      positions[spot] != SYMBOL_X && positions[spot] != SYMBOL_O
    end

    def someone_won_or_tied_game?
      someone_won? || tied_game?
    end

    def someone_won?
      has_winning_combination?
    end

    def tied_game?
      positions.all? { |s| s == SYMBOL_X || s == SYMBOL_O }
    end

    def winner
      has_winning_combination? ? winner_symbol(winning_combination) : nil
    end

    def has_winning_combination?
      !winning_combination.nil?
    end

    def winner_symbol(combination)
      positions[combination[0]]
    end

    def winning_combination
      WINNING_COMBINATIONS.select{|combination| has_completed_combinantion?(combination) }.first
    end

    def has_completed_combinantion?(combination )
      positions[combination[0]] == positions[combination[1]] && positions[combination[1]] == positions[combination[2]]
    end

    def clean
      Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"])
    end
  end
end