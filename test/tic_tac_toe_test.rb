require 'test_helper'

class GameTest < Minitest::Test
  include IoTestHelpers

  def setup
    @io_interface = CommandLineGames::IOInterface.new
    board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"])
    @subject = CommandLineGames::Game.new(@io_interface, board)
  end

  def test_play_game_with_simple_sequence_0_1_3_to_lose_from_default_game_io
    output = "##################################################\n############    Tic Tac Toe    ###################\n#### by Command Lines Games Inc. - March/2017 ####\n##################################################\n\nEnter q any time to exit.\n\nPlayer 1\nChoose player's type. H for human or C for computer:\nChoose player's symbol. X or O\nChoose player's name\nPlayer 2\nChoose player's type. H for human or C for computer:\nDifficulty level\n(E)asy - (M)edium - (H)ard [default is M]:\n\nPlayer 1 - Mr. Smith (O)\n\nPlayer 2 - Computer (X)\n\nLet's play! \\0/\n\n 1 | 2 | 3 \n===+===+===\n 4 | 5 | 6 \n===+===+===\n 7 | 8 | 9 \nMr. Smith (O) turn\nEnter [1-9]:\n O | 2 | 3 \n===+===+===\n 4 | 5 | 6 \n===+===+===\n 7 | 8 | 9 \nComputer (X) turn\n O | 2 | 3 \n===+===+===\n 4 | X | 6 \n===+===+===\n 7 | 8 | 9 \nMr. Smith (O) turn\nEnter [1-9]:\n O | O | 3 \n===+===+===\n 4 | X | 6 \n===+===+===\n 7 | 8 | 9 \nComputer (X) turn\n O | O | X \n===+===+===\n 4 | X | 6 \n===+===+===\n 7 | 8 | 9 \nMr. Smith (O) turn\nEnter [1-9]:\n O | O | X \n===+===+===\n O | X | 6 \n===+===+===\n 7 | 8 | 9 \nComputer (X) turn\n O | O | X \n===+===+===\n O | X | 6 \n===+===+===\n X | 8 | 9 \nPlayer Computer (X) wins!!! =)\nGame over\n"

    assert_output output do
      simulate_stdin("H", "O", "Mr. Smith", "C", "N", "1", "2", "4") { @subject.start_game }
    end
  end

  def test_draw_the_board
    @io_interface_stub = IOInterfaceStub.new
    output = " 1 | 2 | 3 \n===+===+===\n 4 | 5 | 6 \n===+===+===\n 7 | 8 | 9 \n"

    @io_interface_stub.draw_board(["0", "1", "2", "3", "4", "5", "6", "7", "8"])

    assert_equal @io_interface_stub.content, output
  end
end
