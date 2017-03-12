require 'test_helper'

class PlayerTest < Minitest::Test

  def setup
    @io_interface_stub = GameIOStub.new
    @board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"], @io_interface_stub)
    @game = CommandLineGames::Game.new(@io_interface_stub, @board)
    @subject = CommandLineGames::HumanPlayer.new(@io_interface_stub, @game)
    @next_player = CommandLineGames::HumanPlayer.new(@io_interface_stub, @game)
  end

  def test_create_player_by_type_choice
    assert_instance_of CommandLineGames::HumanPlayer, CommandLineGames::Player.create_player("H", @io_interface_stub, @game)    
  end

  def test_player_choice_computer_1
    player = CommandLineGames::ComputerPlayer.new(@io_interface_stub, @game)
    board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"], @io_interface_stub)
    
    assert_equal player.choice(@next_player, board), 4
  end

  def test_player_choice_computer_2
    player = CommandLineGames::ComputerPlayer.new(@io_interface_stub, @game)
    board = CommandLineGames::Board.new(["0", "1", "2", "3", "X", "5", "6", "7", "8"], @io_interface_stub)

    refute_equal player.choice(@next_player, board), 4
  end

  def test_player_choice_human_1
    @io_interface_stub.input = "0"

    assert_equal @subject.choice(@next_player, @board), "0"
  end

  def test_player_choice_human_2
    @io_interface_stub.input = "1"

    assert_equal @subject.choice(@next_player, @board), "1"
  end 

  def test_handle_player_good_input_number
    @io_interface_stub.input = "1"

    assert_equal @subject.choice(@next_player, @board), "1"
  end

  def test_handle_player_bad_input_not_number
    @io_interface_stub.input = "x"

    assert_raises RuntimeError do 
      @subject.choice(@next_player, @board)
    end
  end

  def test_choose_player_symbol_for_human_1
    @io_interface_stub.input = "X"
    
    @subject.choose_symbol(["X","O"])

    assert_equal @subject.symbol, "X"
  end

  def test_choose_player_symbol_for_computer_1
    player = CommandLineGames::ComputerPlayer.new(@io_interface_stub, @game)

    player.choose_symbol(["X","O"])

    assert_equal player.symbol, "X"
  end

  def test_choose_player_name_for_human
    skip
    @io_interface_stub.input = "Mr. Smith"

    @subject.choose_name

    assert_equal @subject.name, "Mr. Smith"
  end
end