
module CommandLineGames
  class Game
    X_SYMBOL = "X"
    O_SYMBOL = "O"
    attr_reader :game_input_output, :current_board, :player_1, :player_2

    def initialize(game_io, board)
      @current_board = board
      @game_input_output = game_io

      @com = X_SYMBOL # the computer's marker
      @hum = O_SYMBOL # the user's marker
      @player_1 = HumanPlayer.new(@hum, game_io, self)
      @player_2 = ComputerPlayer.new(@com, game_io, self)
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
        player_move(player_1, player_2)
        player_move(player_2, player_1) if keep_playing?(board)
        current_board.draw
      end
    end

    def did_game_finish?(board)
      game_is_over(board) || tie(board)
    end
    
    def keep_playing?(board)
      !game_is_over(board) && !tie(board)
    end

    def player_move(player, next_player)
      get_and_mark_player_choice_on_board(player, next_player)
    rescue HumanBadInputError
      handle_bad_input
      player_move(player, next_player)
    rescue PositionIsNotAvailableError  
      handle_position_is_not_available
      player_move(player, next_player)
    end

    def get_and_mark_player_choice_on_board(player, next_player)
      choice = player.choice(next_player, current_board).to_i
      position_is_not_available(choice)
      current_board.mark_position(choice.to_i, player.symbol)
    end

    def handle_bad_input
      game_input_output.bad_input 
      game_input_output.show_input_options
    end

    def handle_position_is_not_available
      game_input_output.position_not_available 
      game_input_output.show_input_options  
    end

    def position_is_not_available(input)
      fail(PositionIsNotAvailableError, 'Position is not available') unless current_board.is_position_available?(input.to_i)
    end

    def get_best_move(board, current_player_symbol, next_player_symbol, depth = 0, best_score = {})
      available_spaces = []
      best_move = nil
      
      ### get the available spaces in board
      board.each do |s|
        if s != "X" && s != "O"
          available_spaces << s
        end
      end
      

      ### try to evaluate each available board position if him can win or loss
      available_spaces.each do |as|
        board[as.to_i] = current_player_symbol
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = next_player_symbol
          if game_is_over(board)
            best_move = as.to_i
            board[as.to_i] = as
            return best_move
          else
            board[as.to_i] = as
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

  class PositionIsNotAvailableError < RuntimeError
  end
end