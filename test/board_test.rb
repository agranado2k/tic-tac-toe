require 'test_helper'

class BoardTest < Minitest::Test
  def setup
    tic_tac_toe_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @game_io = GameIOStub.new
    @subject = CommandLineGames::Board.new(tic_tac_toe_board, @game_io)
  end

  def test_draw_the_board
    output = " 0 | 1 | 2 \n===+===+===\n 3 | 4 | 5 \n===+===+===\n 6 | 7 | 8 \n"

    @subject.draw

    assert_equal @game_io.content, output
  end

  def test_initial_board_for_tic_tac_toe
    initial_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]

    assert_equal @subject.positions, initial_board
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
    board = CommandLineGames::Board.new(tic_tac_toe_board, @game_io)

    assert_equal board.availabel_positions, [0,2,4,5,7,8]
  end
end