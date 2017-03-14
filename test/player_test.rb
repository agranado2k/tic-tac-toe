require 'test_helper'

class PlayerTest < Minitest::Test

  def setup
    @io_interface_stub = IOInterfaceStub.new
    @board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"], @io_interface_stub)
    @humnan_player = CommandLineGames::HumanPlayer.new(@io_interface_stub)
    @computer_player = CommandLineGames::ComputerPlayer.new(@io_interface_stub)
    @computer_player.strategy = CommandLineGames::Strategy.new(@board)
    @next_player = CommandLineGames::HumanPlayer.new(@io_interface_stub)
  end

  def test_create_player_by_type_choice
    assert_instance_of CommandLineGames::HumanPlayer, CommandLineGames::Player.create_player("H", @io_interface_stub)    
  end

  def test_player_choice_computer_1
    assert_equal @computer_player.choice(@next_player), 4
  end

  def test_player_choice_computer_2
    board = CommandLineGames::Board.new(["0", "1", "2", "3", "X", "5", "6", "7", "8"], @io_interface_stub)
    computer_player = CommandLineGames::ComputerPlayer.new(@io_interface_stub)
    computer_player.strategy = CommandLineGames::Strategy.new(board)

    refute_equal computer_player.choice(@next_player), 4
  end

  def test_player_choice_human_1
    @io_interface_stub.input = "0"

    assert_equal @humnan_player.choice(@next_player), "0"
  end

  def test_player_choice_human_2
    @io_interface_stub.input = "1"

    assert_equal @humnan_player.choice(@next_player), "1"
  end 

  def test_handle_player_good_input_number
    @io_interface_stub.input = "1"

    assert_equal @humnan_player.choice(@next_player), "1"
  end

  def test_handle_player_bad_input_not_number
    @io_interface_stub.input = "x"

    assert_raises RuntimeError do 
      @humnan_player.choice(@next_player)
    end
  end

  def test_choose_player_symbol_for_human_1
    @io_interface_stub.input = "X"
    
    @humnan_player.choose_symbol(["X","O"])

    assert_equal @humnan_player.symbol, "X"
  end

  def test_choose_player_symbol_for_computer_1
    @computer_player.choose_symbol(["X","O"])

    assert_equal @computer_player.symbol, "X"
  end

  def test_choose_player_name_for_human
    @io_interface_stub.input = "Mr. Smith"

    @humnan_player.choose_name

    assert_equal @humnan_player.name, "Mr. Smith"
  end
end