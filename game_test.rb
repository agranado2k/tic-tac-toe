#!/usr/bin/env ruby

gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'game'
require_relative 'io_test_helpers'

class GameTest < Minitest::Test
  include IoTestHelpers

  def test_play_game_with_simple_sequence_0_1_3
    game = Game.new
    output = " 0 | 1 | 2 \n===+===+===\n 3 | 4 | 5 \n===+===+===\n 6 | 7 | 8 \nEnter [0-8]:\n O | 1 | 2 \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \n O | O | X \n===+===+===\n 3 | X | 5 \n===+===+===\n 6 | 7 | 8 \n O | O | X \n===+===+===\n O | X | 5 \n===+===+===\n X | 7 | 8 \nGame over\n"

    assert_output output do
      simulate_stdin("0", "1", "3") { game.start_game }
    end
  end
end
