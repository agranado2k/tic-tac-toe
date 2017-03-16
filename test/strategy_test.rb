require 'test_helper'

class BoardTest < Minitest::Test

  def test_hard_strategy_1
    current_symbol = "X"
    tic_tac_toe_board = ["0", "1", "2", "3", "O", "5", "6", "7", "8"]
    game_io = IOInterfaceStub.new
    board = CommandLineGames::Board.new(tic_tac_toe_board, game_io)
    strategy = CommandLineGames::Strategies::Hard.new(board, current_symbol)

    assert_equal strategy.get_best_move(current_symbol), 0
  end

  def test_hard_strategy_2
    current_symbol = "O"
    tic_tac_toe_board = ["X", "1", "X", "3", "4", "5", "O", "O", "8"]
    game_io = IOInterfaceStub.new
    board = CommandLineGames::Board.new(tic_tac_toe_board, game_io)
    strategy = CommandLineGames::Strategies::Hard.new(board, current_symbol)

    assert_equal strategy.get_best_move(current_symbol), 1
  end
end