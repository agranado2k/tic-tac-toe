#!/usr/bin/env ruby

gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'game'
require_relative 'io_test_helpers'

class GameIOSub < GameIO
  attr_accessor :input
  attr_reader :content

  def initialize
    @content = ''
  end

  def waiting_for_input
    input
  end

  def output(content)
    @content += "#{content}"
  end
end

class GameTest < Minitest::Test
  include IoTestHelpers

  def setup
    @subject = Game.new(GameIO.new)
  end

  def test_play_game_with_simple_sequence_0_1_3_to_lose_from_default_game_io
    output = " 0 | 1 | 2 \n===+===+===\n 3 | 4 | 5 \n===+===+===\n 6 | 7 | 8 \nEnter [0-8]:\n O | 1 | 2 \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \n O | O | X \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \n O | O | X \n===+===+===\n O | X | 5 \n===+===+===\n X | 7 | 8 \nGame over\n"

    assert_output output do
      simulate_stdin("0", "1", "3") { @subject.start_game }
    end
  end

  ##### Game IO
  def test_initial_game_board
    assert_equal @subject.board, ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  end

  def test_player_move
    @subject.player_move("0", "O", @subject.board)

    assert_equal @subject.board, ["O", "1", "2", "3", "4", "5", "6", "7", "8"]
  end

  def test_draw_initial_board
    initial_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    output = " 0 | 1 | 2 \n===+===+===\n 3 | 4 | 5 \n===+===+===\n 6 | 7 | 8 \n"

    game_io = GameIO.new

    assert_equal game_io.board_template(initial_board), output
  end

  def test_start_game_printing_board
    initial_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    output = " 0 | 1 | 2 \n===+===+===\n 3 | 4 | 5 \n===+===+===\n 6 | 7 | 8 \nEnter [0-8]:"

    game = Game.new(GameIOSub.new)

    assert_equal game.start_by_printing_the_board(initial_board), output
  end

  def test_player_move_in_position_0
    result_board = ["O", "1", "2", "3", "4", "5", "6", "7", "8"]

    @subject.player_move(0, "O", @subject.board)

    assert_equal @subject.board, result_board
  end

  def test_player_move_in_positions_0_3_7
    result_board = ["O", "1", "2", "O", "4", "5", "6", "O", "8"]
    
    @subject.player_move(0, "O", @subject.board)
    @subject.player_move(3, "O", @subject.board)
    @subject.player_move(7, "O", @subject.board)

    assert_equal @subject.board, result_board
  end

  def test_handle_player_good_input_number
    board = ["0", "1", "2", "3", "X", "5", "6", "7", "8"]
    game_io = GameIOSub.new
    game_io.input = "1"
    game = Game.new(game_io)

    assert_equal game.game_input_output_human_choice(board), "1"
  end

  def test_handle_player_bad_input_not_number_1
    board = ["0", "O", "2", "3", "X", "5", "6", "7", "8"]
    game_io = GameIOSub.new
    game_io.input = "x"
    game = Game.new(game_io)

    game.game_input_output_human_choice(board)

    assert_equal game_io.content, "Ops... Invalid input!Enter [0-8]:"
  end

  def test_handle_player_bad_input_not_number_2
    board = ["X", "O", "2", "3", "X", "5", "6", "O", "8"]
    game_io = GameIOSub.new
    game_io.input = "x"
    game = Game.new(game_io)

    game.game_input_output_human_choice(board)

    assert_equal game_io.content, "Ops... Invalid input!Enter [0-8]:"
  end

  def test_handle_player_bad_input_position_has_already_been_chosen
    board = ["0", "1", "2", "3", "X", "5", "6", "7", "8"]
    game_io = GameIOSub.new
    game_io.input = "4"
    game = Game.new(game_io)

    game.game_input_output_human_choice(board)

    assert_equal game_io.content, "Positions has already been chosen.Enter [0-8]:"
  end

  def test_despite_of_player_bad_input_should_keep_ask_for_correct_input
    board = ["0", "1", "2", "3", "X", "5", "6", "7", "8"]
    game_io = GameIOSub.new
    game_io.input = "4"
    game = Game.new(game_io)

    game.game_input_output_human_choice(board)
    game_io.input = "5"
    game.game_input_output_human_choice(board)

    assert_equal game.game_input_output_human_choice(board), "5"
    assert_equal game_io.content, "Positions has already been chosen.Enter [0-8]:"
  end
end

