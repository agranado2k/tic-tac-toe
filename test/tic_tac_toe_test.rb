require 'test_helper'

class GameTest < Minitest::Test
  include IoTestHelpers

  def setup
    @io_interface_stub = GameIOStub.new
    board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"], @io_interface_stub)
    @subject = CommandLineGames::Game.new(@io_interface_stub, board)
  end

  def test_play_game_with_simple_sequence_0_1_3_to_lose_from_default_game_io
    io_interface = CommandLineGames::GameIO.new
    board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"], io_interface)
    @game = CommandLineGames::Game.new(io_interface, board)
    output = "Player 1\nChoose player type. H for human or C for computer:\nChoose player symbol. X or O\nPlayer 2\nChoose player type. H for human or C for computer:\n 0 | 1 | 2 \n===+===+===\n 3 | 4 | 5 \n===+===+===\n 6 | 7 | 8 \nPlayer 1 turn\nEnter [0-8]:\n O | 1 | 2 \n===+===+===\n 3 | 4 | 5 \n===+===+===\n 6 | 7 | 8 \nPlayer 2 turn\n O | 1 | 2 \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \nPlayer 1 turn\nEnter [0-8]:\n O | O | 2 \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \nPlayer 2 turn\n O | O | X \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \nPlayer 1 turn\nEnter [0-8]:\n O | O | X \n===+===+===\n O | X | 5 \n===+===+===\n 6 | 7 | 8 \nPlayer 2 turn\n O | O | X \n===+===+===\n O | X | 5 \n===+===+===\n X | 7 | 8 \nGame over\n"

    assert_output output do
      simulate_stdin("H", "O", "C", "0", "1", "3") { @game.start_game }
    end
  end
end
