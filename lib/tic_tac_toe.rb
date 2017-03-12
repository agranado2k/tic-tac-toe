#!/usr/bin/env ruby

require_relative "./tic_tac_toe/version"

require_relative "command_line_games/game_io"
require_relative "command_line_games/board"
require_relative "command_line_games/game"

# game_io = CommandLineGames::GameIO.new
# board = CommandLineGames::Board.new(["0", "1", "2", "3", "4", "5", "6", "7", "8"], game_io)
# game = CommandLineGames::Game.new(game_io, board)
# game.start_game