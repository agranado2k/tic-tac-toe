class GameIO
  def draw_board(board)
    output board_template(board)
  end

  def board_template(board)
    " #{board[0]} | #{board[1]} | #{board[2]} \n===+===+===\n #{board[3]} | #{board[4]} | #{board[5]} \n===+===+===\n #{board[6]} | #{board[7]} | #{board[8]} \n"
  end

  def show_input_options
    output "Enter [0-8]:"
  end

  def game_over_message
    output "Game over"
  end

  def bad_input
    output "Ops... Invalid input!"
  end

  def position_not_available
    output "Positions has already been chosen."
  end

  def waiting_for_input
    input
  end

  def output(content)
    puts content
  end

  def input
    gets.chomp
  end
end

class Game
  attr_reader :board, :game_input_output

  def initialize(game_input_output=GameIO.new)
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = "X" # the computer's marker
    @hum = "O" # the user's marker
    @game_input_output = game_input_output
  end

  def start_game
    start_by_printing_the_board(board)

    play_game(board)
    
    finish_game
  end

  def start_by_printing_the_board(board)
    draw_board(board)
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
      player_move(human_choice(board), @hum, board)
      player_move(computer_choice(board), @com, board) if keep_playing?
      draw_board(board)
    end
  end

  def did_game_finish?(board)
    game_is_over(board) || tie(board)
  end
  
  def keep_playing?
    !game_is_over(board) && !tie(board)
  end
  
  def draw_board(draw_board)
    game_input_output.draw_board(board)
  end

  def player_move(choice, symbol, board)
    spot = nil
    until spot
      spot = check_and_set_choice_on_the_board(board, choice.to_i, symbol)
    end
  end

  def check_and_set_choice_on_the_board(board, spot, symbol)
    if is_position_available?(@board, spot)
      set_board_position(@board, spot, symbol)
    else
      spot = nil
    end
    spot
  end

  def human_choice(board)
    input = nil
    input = game_input_output_human_choice(board) until input
    input
  end

  def game_input_output_human_choice(board)
    input = game_input_output.waiting_for_input
    input = nil if invalid_input?(input, board)
    input
  end

  def invalid_input?(input, board)
    return true if bad_input?(input, board)
    return true if position_is_not_available(input, board)
    false
  end

  def bad_input?(input, board)
    if input.match(/[^0-8]/)
      game_input_output.bad_input 
      game_input_output.show_input_options
      return true 
    end
    false
  end

  def position_is_not_available(input, board)
    if !is_position_available?(board, input.to_i)
      game_input_output.position_not_available 
      game_input_output.show_input_options
      return true
    end
    false
  end

  def computer_choice(board)
    return 4 if board[4] == "4"
    get_best_move(board, @com)
  end

  def set_board_position(board, spot, mark)
    board[spot] = mark
  end

  def is_position_available?(board, spot)
    board[spot] != "X" && board[spot] != "O"
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

end

# game = Game.new
# game.start_game
