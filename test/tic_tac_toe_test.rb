require 'test_helper'

class GameTest < Minitest::Test
  include IoTestHelpers

  def setup
    game_io = CommandLineGames::GameIO.new
    board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"], game_io)
    @subject = CommandLineGames::Game.new(game_io, board)
    @game_io_stub = GameIOStub.new
  end

  def test_play_game_with_simple_sequence_0_1_3_to_lose_from_default_game_io
    output = " 0 | 1 | 2 \n===+===+===\n 3 | 4 | 5 \n===+===+===\n 6 | 7 | 8 \nEnter [0-8]:\n O | 1 | 2 \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \n O | O | X \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \n O | O | X \n===+===+===\n O | X | 5 \n===+===+===\n X | 7 | 8 \nGame over\n"

    assert_output output do
      simulate_stdin("0", "1", "3") { @subject.start_game }
    end
  end

  ##### Game IO
  def test_initial_game_board
    assert_equal @subject.board_positions, ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  end

  def test_player_move
    @subject.player_move("0", "O")

    assert_equal @subject.board_positions, ["O", "1", "2", "3", "4", "5", "6", "7", "8"]
  end

  def test_draw_initial_board
    initial_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    output = " 0 | 1 | 2 \n===+===+===\n 3 | 4 | 5 \n===+===+===\n 6 | 7 | 8 \n"

    game_io = CommandLineGames::GameIO.new

    assert_equal game_io.board_template(initial_board), output
  end

  def test_player_move_in_position_0
    result_board = ["O", "1", "2", "3", "4", "5", "6", "7", "8"]

    @subject.player_move(0, "O")

    assert_equal @subject.board_positions, result_board
  end

  def test_player_move_in_positions_0_3_7
    result_board = ["O", "1", "2", "O", "4", "5", "6", "O", "8"]
    
    @subject.player_move(0, "O")
    @subject.player_move(3, "O")
    @subject.player_move(7, "O")

    assert_equal @subject.board_positions, result_board
  end

  def test_handle_player_good_input_number
    positions = ["0", "1", "2", "3", "X", "5", "6", "7", "8"]
    game_io = GameIOStub.new
    board = CommandLineGames::Board.new(positions, game_io)
    game_io.input = "1"
    game = CommandLineGames::Game.new(game_io, board)

    assert_equal game.game_input_output_human_choice, "1"
  end

  def test_handle_player_bad_input_not_number_1
    positions = ["0", "O", "2", "3", "X", "5", "6", "7", "8"]
    game_io = GameIOStub.new
    game_io.input = "x"
    board = CommandLineGames::Board.new(positions, game_io)
    game = CommandLineGames::Game.new(game_io, board)

    game.game_input_output_human_choice

    assert_equal game_io.content, "Ops... Invalid input!Enter [0-8]:"
  end

  def test_handle_player_bad_input_not_number_2
    positions = ["X", "O", "2", "3", "X", "5", "6", "O", "8"]
    game_io = GameIOStub.new
    game_io.input = "x"
    board = CommandLineGames::Board.new(positions, game_io)
    game = CommandLineGames::Game.new(game_io, board)

    game.game_input_output_human_choice

    assert_equal game_io.content, "Ops... Invalid input!Enter [0-8]:"
  end

  def test_handle_player_bad_input_position_has_already_been_chosen
    positions = ["0", "1", "2", "3", "X", "5", "6", "7", "8"]
    game_io = GameIOStub.new
    game_io.input = "4"
    board = CommandLineGames::Board.new(positions, game_io)
    game = CommandLineGames::Game.new(game_io, board)

    game.game_input_output_human_choice

    assert_equal game_io.content, "Positions has already been chosen.Enter [0-8]:"
  end

  def test_despite_of_player_bad_input_should_keep_ask_for_correct_input
    positions = ["0", "1", "2", "3", "X", "5", "6", "7", "8"]
    game_io = GameIOStub.new
    game_io.input = "4"
    board = CommandLineGames::Board.new(positions, game_io)
    game = CommandLineGames::Game.new(game_io, board)

    game.game_input_output_human_choice
    game_io.input = "5"
    game.game_input_output_human_choice

    assert_equal game.game_input_output_human_choice, "5"
    assert_equal game_io.content, "Positions has already been chosen.Enter [0-8]:"
  end
end

