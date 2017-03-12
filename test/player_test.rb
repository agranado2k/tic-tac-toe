require 'test_helper'

class PlayerTest < Minitest::Test

  def setup
    @game_io = GameIOStub.new
    @board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"], @game_io)
    @game = CommandLineGames::Game.new(@game_io, @board)
    @next_player = CommandLineGames::HumanPlayer.new(CommandLineGames::Game::X_SYMBOL, @game_io, @game)
  end

  def test_player_choice_computer_1
    player = CommandLineGames::ComputerPlayer.new(CommandLineGames::Game::O_SYMBOL, @game_io, @game)
    board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"], @game_io)
    
    assert_equal player.player_choice(@next_player, board), 4
  end

  def test_player_choice_computer_2
    player = CommandLineGames::ComputerPlayer.new(CommandLineGames::Game::O_SYMBOL, @game_io, @game)
    board = CommandLineGames::Board.new(["0", "1", "2", "3", "X", "5", "6", "7", "8"], @game_io)

    refute_equal player.player_choice(@next_player, board), 4
  end

  def test_player_choice_human_1
    player = CommandLineGames::HumanPlayer.new(CommandLineGames::Game::O_SYMBOL, @game_io, @game)
    @game_io.input = "0"

    assert_equal player.player_choice(@next_player, @board), "0"
  end

  def test_player_choice_human_2
    player = CommandLineGames::HumanPlayer.new(CommandLineGames::Game::O_SYMBOL, @game_io, @game)
    @game_io.input = "1"

    assert_equal player.player_choice(@next_player, @board), "1"
  end 

  def test_handle_player_good_input_number
    player = CommandLineGames::HumanPlayer.new(CommandLineGames::Game::O_SYMBOL, @game_io, @game)
    @game_io.input = "1"

    assert_equal player.player_choice(@next_player, @board), "1"
  end

  def test_handle_player_bad_input_not_number
    player = CommandLineGames::HumanPlayer.new(CommandLineGames::Game::O_SYMBOL, @game_io, @game)
    @game_io.input = "x"

    assert_raises RuntimeError do 
      player.player_choice(@next_player, @board)
    end
  end
end