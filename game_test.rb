#!/usr/bin/env ruby

gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'game'
require_relative 'io_test_helpers'

class GameIOSub < GameIO
  def initialize
    @content = ''
  end

  def output(content)
    @content += content
    @content
  end

  def input
    
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
    @subject.player_move("0", "O")

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

    @subject.player_move(0, "O")

    assert_equal @subject.board, result_board
  end

  def test_player_move_in_positions_0_3_7
    result_board = ["O", "1", "2", "O", "4", "5", "6", "O", "8"]
    
    @subject.player_move(0, "O")
    @subject.player_move(3, "O")
    @subject.player_move(7, "O")

    assert_equal @subject.board, result_board
  end
end

