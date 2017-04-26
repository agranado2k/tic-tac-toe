require 'test_helper'

class BoardTest < Minitest::Test

  def test_hard_strategy_1
    current_symbol = "X"
    tic_tac_toe_board = ["0", "1", "2", "3", "O", "5", "6", "7", "8"]
    board = CommandLineGames::Board.new(tic_tac_toe_board)
    strategy = CommandLineGames::Strategies::Hard.new(board, current_symbol)

    assert_equal strategy.get_best_move(current_symbol), 0
  end

  def test_hard_strategy_2
    current_symbol = "O"
    tic_tac_toe_board = ["X", "1", "X", "3", "4", "5", "O", "O", "8"]
    board = CommandLineGames::Board.new(tic_tac_toe_board)
    strategy = CommandLineGames::Strategies::Hard.new(board, current_symbol)

    assert_equal strategy.get_best_move(current_symbol), 1
  end

  def test_easy_strategy
    current_symbol = "O"
    tic_tac_toe_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    board = CommandLineGames::Board.new(tic_tac_toe_board)
    strategy = CommandLineGames::Strategies::Easy.new(board, current_symbol)

    assert_includes (0..8), strategy.get_best_move(current_symbol)
  end

  def test_normal_strategy_1
    current_symbol = "O"
    tic_tac_toe_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    board = CommandLineGames::Board.new(tic_tac_toe_board)
    strategy = CommandLineGames::Strategies::Normal.new(board, current_symbol)

    assert_equal strategy.get_best_move(current_symbol), 4
  end

  def test_normal_strategy_2
    current_symbol = "O"
    tic_tac_toe_board = ["0", "1", "2", "3", "X", "5", "6", "7", "8"]
    board = CommandLineGames::Board.new(tic_tac_toe_board)
    strategy = CommandLineGames::Strategies::Normal.new(board, current_symbol)

    refute_equal strategy.get_best_move(current_symbol), 4
  end
end