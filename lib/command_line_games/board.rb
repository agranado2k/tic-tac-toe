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

    def set_board_position(spot, mark)
      positions[spot] = mark
    end

    def is_position_available?(spot)
      positions[spot] != "X" && positions[spot] != "O"
    end
  end
end