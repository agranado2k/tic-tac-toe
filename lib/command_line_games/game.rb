module CommandLineGames
  class Game
    attr_reader :game_input_output, :current_board

    def initialize(game_io, board)
      @current_board = board
      @game_input_output = game_io

      @com = "X" # the computer's marker
      @hum = "O" # the user's marker
    end

    def start_game
      setup_game(board_positions)

      play_game(board_positions)
      
      finish_game
    end

    def setup_game(board)
      current_board.draw
      show_input_options
    end

    def show_input_options
      game_input_output.show_input_options
    end

    def finish_game
      show_game_over_message
    end
    
    def show_game_over_message
      game_input_output.game_over_message
    end

    def play_game(board)
      until did_game_finish?(board)
        player_move(human_choice, @hum)
        player_move(computer_choice, @com) if keep_playing?(board)
        current_board.draw
      end
    end

    def did_game_finish?(board)
      game_is_over(board) || tie(board)
    end
    
    def keep_playing?(board)
      !game_is_over(board) && !tie(board)
    end

    def player_move(choice, symbol)
      spot = nil
      until spot
        spot = check_and_set_choice_on_the_board(choice.to_i, symbol)
      end
    end

    def check_and_set_choice_on_the_board(spot, symbol)
      if current_board.is_position_available?(spot)
        current_board.set_board_position(spot, symbol)
      else
        spot = nil
      end
      spot
    end

    def human_choice
      input = nil
      input = game_input_output_human_choice until input
      input
    end

    def game_input_output_human_choice
      input = game_input_output.waiting_for_input
      input = nil if invalid_input?(input)
      input
    end

    def invalid_input?(input)
      return true if bad_input?(input)
      return true if position_is_not_available(input)
      false
    end

    def bad_input?(input)
      if input.match(/[^0-8]/)
        game_input_output.bad_input 
        game_input_output.show_input_options
        return true 
      end
      false
    end

    def position_is_not_available(input)
      if !current_board.is_position_available?(input.to_i)
        game_input_output.position_not_available 
        game_input_output.show_input_options
        return true
      end
      false
    end

    def computer_choice
      return 4 if current_board.is_position_available?(4)
      get_best_move(board_positions, @com)
    end
    
    def get_best_move(board, next_player, depth = 0, best_score = {})
      available_spaces = []
      best_move = nil
      board.each do |s|
        if s != "X" && s != "O"
          available_spaces << s
        end
      end
      available_spaces.each do |as|
        board[as.to_i] = @com
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = @hum
          if game_is_over(board)
            best_move = as.to_i
            board[as.to_i] = as
            return best_move
          else
            board[as.to_i] = as
          end
        end
      end
      if best_move
        return best_move
      else
        n = rand(0..available_spaces.count)
        return available_spaces[n].to_i
      end
    end

    def game_is_over(b)

      [b[0], b[1], b[2]].uniq.length == 1 ||
      [b[3], b[4], b[5]].uniq.length == 1 ||
      [b[6], b[7], b[8]].uniq.length == 1 ||
      [b[0], b[3], b[6]].uniq.length == 1 ||
      [b[1], b[4], b[7]].uniq.length == 1 ||
      [b[2], b[5], b[8]].uniq.length == 1 ||
      [b[0], b[4], b[8]].uniq.length == 1 ||
      [b[2], b[4], b[6]].uniq.length == 1
    end

    def tie(b)
      b.all? { |s| s == "X" || s == "O" }
    end

    def board_positions
      current_board.positions
    end
  end
end

# game = Game.new(GameIO.new)
# game.start_game