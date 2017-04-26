
module CommandLineGames
  class Game
    include GameConfigurator
    PLAYER_1 = 1
    PLAYER_2 = 2

    attr_reader :io_interface, :board, :player_1, :player_2, :winner
    attr_accessor :symbols

    def initialize(io_interface, board)
      @board = board
      @io_interface = io_interface
      @symbols = SYMBOL_LIST
    end

    def start_game
      introduction
      setup_players
      setup_and_draw_board
      play_game(board)
      finish_game
    end

    def introduction
      @io_interface.introduction
    end

    def setup_players
      @player_1 = setup_player(@player_1, PLAYER_1)
      @player_2 = setup_player(@player_2, PLAYER_2)
      io_interface.player_setup(PLAYER_1, @player_1.name, @player_1.symbol)
      io_interface.player_setup(PLAYER_2, @player_2.name, @player_2.symbol)
    end

    def remove_symbol_from_list(symbol)
      symbols.delete(symbol)
    end
    
    def setup_and_draw_board
      io_interface.lets_play
      board.clean
      io_interface.draw_board(board.positions)
    end

    def play_game(board)
      until board.someone_won_or_tied_game?
        player_move(player_1, player_2)
        break if board.someone_won_or_tied_game?
        player_move(player_2, player_1)
      end
    end

    def player_move(player, next_player)
      handle_players_choice(player, next_player)
      @winner = player
    rescue Errors::HumanBadInput
      handle_bad_input(player, next_player)
    rescue Errors::PositionIsNotAvailable  
      handle_position_is_not_available(player, next_player)
    end

    def handle_players_choice(player, next_player)
      io_interface.player_turn(player.name, player.symbol)
      choice = player.choice.to_i
      position_is_not_available(choice)
      mark_and_draw_postion_on_board(choice.to_i, player.symbol)
    end

    def mark_and_draw_postion_on_board(choice, symbol)
      board.mark_position(choice, symbol)
      io_interface.draw_board(board.positions)
    end

    def handle_bad_input(player, next_player)
      io_interface.bad_input 
      io_interface.show_input_options
      player_move(player, next_player)
    end

    def handle_position_is_not_available(player, next_player)
      io_interface.position_not_available 
      io_interface.show_input_options
      player_move(player, next_player)
    end
    
    def show_input_options
      io_interface.show_input_options
    end

    def position_is_not_available(input)
      fail(Errors::PositionIsNotAvailable, 'Position is not available') unless board.is_position_available?(input.to_i)
    end

    def finish_game
      if board.tied_game?
        show_tied_game_message
      else
        show_winner_message(winner.name, winner.symbol)        
      end
      show_game_over_message
    end

    def show_tied_game_message
      io_interface.show_tied_game_message
    end

    def show_winner_message(name, symbol=nil)
      io_interface.winner_message(name, symbol)
    end
    
    def show_game_over_message
      io_interface.game_over_message
    end
  end
end