module CommandLineGames  
  class Board
    attr_reader :positions, :game_input_output

    def initialize(board, game_input_output)
      @positions = board
      @game_input_output = game_input_output
    end

    def draw
      game_input_output.draw_board(positions)
    end

    def mark_position(spot, mark)
      positions[spot] = mark
    end

    def availabel_positions
      positions.select.with_index{|position, index| is_position_available?(index)}.map(&:to_i)
    end

    def is_position_available?(spot)
      positions[spot] != "X" && positions[spot] != "O"
    end
  end
end