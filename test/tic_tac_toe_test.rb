require 'test_helper'

class GameTest < Minitest::Test
  include IoTestHelpers

  def setup
    game_io = CommandLineGames::GameIO.new
    board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"], game_io)
    @subject = CommandLineGames::Game.new(game_io, board)
  end

  def test_play_game_with_simple_sequence_0_1_3_to_lose_from_default_game_io
    output = " 0 | 1 | 2 \n===+===+===\n 3 | 4 | 5 \n===+===+===\n 6 | 7 | 8 \nEnter [0-8]:\n O | 1 | 2 \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \n O | O | X \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \n O | O | X \n===+===+===\n O | X | 5 \n===+===+===\n X | 7 | 8 \nGame over\n"

    assert_output output do
      simulate_stdin("0", "1", "3") { @subject.start_game }
    end
  end
end

