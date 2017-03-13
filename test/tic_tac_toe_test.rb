require 'test_helper'

class GameTest < Minitest::Test
  include IoTestHelpers

  def setup
    io_interface = CommandLineGames::IOInterface.new
    board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"], io_interface)
    @subject = CommandLineGames::Game.new(io_interface, board)
  end

  def test_play_game_with_simple_sequence_0_1_3_to_lose_from_default_game_io
    output = "##################################################\n############    Tic Tac Toe    ###################\n#### by Command Lines Games Inc. - March/2017 ####\n##################################################\nPlayer 1\nChoose player's type. H for human or C for computer:\nChoose player's symbol. X or O\nChoose player's name\nPlayer 2\nChoose player's type. H for human or C for computer:\n 0 | 1 | 2 \n===+===+===\n 3 | 4 | 5 \n===+===+===\n 6 | 7 | 8 \nMr. Smith turn\nEnter [0-8]:\n O | 1 | 2 \n===+===+===\n 3 | 4 | 5 \n===+===+===\n 6 | 7 | 8 \nPlayer turn\n O | 1 | 2 \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \nMr. Smith turn\nEnter [0-8]:\n O | O | 2 \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \nPlayer turn\n O | O | X \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \nMr. Smith turn\nEnter [0-8]:\n O | O | X \n===+===+===\n O | X | 5 \n===+===+===\n 6 | 7 | 8 \nPlayer turn\n O | O | X \n===+===+===\n O | X | 5 \n===+===+===\n X | 7 | 8 \nGame over\n"

    assert_output output do
      simulate_stdin("H", "O", "Mr. Smith", "C", "0", "1", "3") { @subject.start_game }
    end
  end
end
