require 'test_helper'

class PlayerTest < Minitest::Test

  def setup
    @game_io = GameIOStub.new
  end

  def test_create_humnam_player
    player = CommandLineGames::Player.new(CommandLineGames::Game::X_SYMBOL, CommandLineGames::Player::HUMAN, @game_io)

    assert_equal player.symbol, CommandLineGames::Game::X_SYMBOL
    assert_equal player.type, CommandLineGames::Player::HUMAN
  end

  def test_create_computer_player
    player = CommandLineGames::Player.new(CommandLineGames::Game::O_SYMBOL, CommandLineGames::Player::COMPUTER, @game_io)

    assert_equal player.symbol, CommandLineGames::Game::O_SYMBOL
    assert_equal player.type, CommandLineGames::Player::COMPUTER
  end

  def test_player_choice_computer
    player = CommandLineGames::Player.new(CommandLineGames::Game::O_SYMBOL, CommandLineGames::Player::COMPUTER, @game_io)
    board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"], @game_io)

    assert_equal player.player_choice(board), 4
  end

  def test_player_choice_human_1
    player = CommandLineGames::Player.new(CommandLineGames::Game::O_SYMBOL, CommandLineGames::Player::HUMAN, @game_io)
    @game_io.input = "0"

    assert_equal player.player_choice, "0"
  end

  def test_player_choice_human_2
    player = CommandLineGames::Player.new(CommandLineGames::Game::O_SYMBOL, CommandLineGames::Player::HUMAN, @game_io)
    @game_io.input = "1"

    assert_equal player.player_choice, "1"
  end 

  def test_handle_player_good_input_number
    player = CommandLineGames::Player.new(CommandLineGames::Game::O_SYMBOL, CommandLineGames::Player::HUMAN, @game_io)
    @game_io.input = "1"

    assert_equal player.player_choice, "1"
  end

  def test_handle_player_bad_input_not_number
    player = CommandLineGames::Player.new(CommandLineGames::Game::O_SYMBOL, CommandLineGames::Player::HUMAN, @game_io)
    @game_io.input = "x"

    assert_raises RuntimeError do 
      player.player_choice
    end
  end
end