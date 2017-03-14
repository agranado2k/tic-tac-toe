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

    def someone_won_or_tied_game?
      someone_won? || tied_game?
    end

    def someone_won?
      [positions[0], positions[1], positions[2]].uniq.length == 1 ||
      [positions[3], positions[4], positions[5]].uniq.length == 1 ||
      [positions[6], positions[7], positions[8]].uniq.length == 1 ||
      [positions[0], positions[3], positions[6]].uniq.length == 1 ||
      [positions[1], positions[4], positions[7]].uniq.length == 1 ||
      [positions[2], positions[5], positions[8]].uniq.length == 1 ||
      [positions[0], positions[4], positions[8]].uniq.length == 1 ||
      [positions[2], positions[4], positions[6]].uniq.length == 1
    end

    def tied_game?
      positions.all? { |s| s == "X" || s == "O" }
    end

    def clean
      @positions = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    end
  end
end