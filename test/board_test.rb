require 'test_helper'

class BoardTest < Minitest::Test
  def setup
    tic_tac_toe_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @subject = CommandLineGames::Board.new(tic_tac_toe_board)
  end

  def test_initial_board_for_tic_tac_toe
    initial_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]

    assert_equal @subject.positions, initial_board
  end

  def test_clean_board
    board = CommandLineGames::Board.new(["0", "1", "O", "3", "X", "5", "X", "O", "8"])

    board.clean

    assert_equal board.positions, ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  end

  def test_set_board_position
    spot, mark = 4, "X"

    @subject.mark_position(spot, mark)

    assert_equal @subject.positions, ["0", "1", "2", "3", "X", "5", "6", "7", "8"]
  end

  def test_is_position_available_on_board_true
    spot = 4

    assert_equal @subject.is_position_available?(spot), true
  end

  def test_is_position_available_on_board_false
    spot, mark = 4, "X"
    @subject.mark_position(spot, mark)

    assert_equal @subject.is_position_available?(spot), false
  end

  def test_available_positions
    tic_tac_toe_board = ["0", "X", "2", "O", "4", "5", "O", "7", "8"]
    board = CommandLineGames::Board.new(tic_tac_toe_board)

    assert_equal board.available_positions, [0,2,4,5,7,8]
  end

  def test_who_won_by_symbol_1
    tic_tac_toe_board = ["X", "X", "X", "O", "4", "5", "O", "7", "8"]

    board = CommandLineGames::Board.new(tic_tac_toe_board)

    assert_equal board.winner, "X"
  end

  def test_who_won_by_symbol_2
    tic_tac_toe_board = ["X", "1", "O", "3", "O", "5", "O", "7", "X"]

    board = CommandLineGames::Board.new(tic_tac_toe_board)

    assert_equal board.winner, "O"
  end
end