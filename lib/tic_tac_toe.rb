#!/usr/bin/env ruby

require_relative "./tic_tac_toe/version"

require_relative "command_line_games/errors/bad_input"
require_relative "command_line_games/errors/position_is_not_available"
require_relative "command_line_games/io_interface"
require_relative "command_line_games/board"
require_relative "command_line_games/player"
require_relative "command_line_games/players/human"
require_relative "command_line_games/players/computer"
require_relative "command_line_games/strategy"
require_relative "command_line_games/strategies/easy"
require_relative "command_line_games/strategies/normal"
require_relative "command_line_games/strategies/hard"
require_relative "command_line_games/game_configurator"
require_relative "command_line_games/game"


module CommandLineGames
  class TicTacToe
    def self.play_game
      io_interface = CommandLineGames::IOInterface.new
      board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"])
      controller = CommandLineGames::Game.new(io_interface, board)
      controller.start_game
    end
  end
end