
module CommandLineGames
  class Game
    SYMBOL_LIST = ["X","O"]

    attr_reader :io_interface, :current_board, :player_1, :player_2, :winner

    def initialize(io_interface, board)
      @current_board = board
      @io_interface = io_interface
      @symbols = SYMBOL_LIST
    end

    def start_game
      introduction
      setup_players
      setup_and_draw_board
      play_game(current_board)
      finish_game
    end

    def introduction
      @io_interface.introduction
    end

    def setup_players
      @player_1 = setup_player_1(@player_1)
      @player_2 = setup_player_2(@player_2)
      io_interface.player_setup(1, @player_1.name, @player_1.symbol)
      io_interface.player_setup(2, @player_2.name, @player_2.symbol)
    end

    def setup_player_1(player)
      player = create_player_1
      player = configure_player(player)
    rescue Errors::HumanBadInput
      io_interface.bad_input
      player = setup_player_1(player)
    ensure
      player
    end

    def create_player_1
      @io_interface.for_player_1
      create_player_by_type
    end

    def setup_player_2(player)
      player = create_player_2
      player = configure_player(player)
    rescue Errors::HumanBadInput
      io_interface.bad_input
      player = setup_player_2(player)
    ensure
      player
    end

    def create_player_2
      @io_interface.for_player_2
      create_player_by_type
    end

    def create_player_by_type
      type = handle_user_input_to_create_player
      Player.create_player(type, @io_interface)
    end

    def handle_user_input_to_create_player
      @io_interface.choose_player_type
      type = @io_interface.waiting_for_input
      fail(Errors::HumanBadInput, 'Bad Input') unless type.upcase.match(/H|C/)
      type
    end
    
    def configure_player(player)
      configure_player_symbol(player)
      configure_player_name(player)
      configure_player_strategy(player)
      player
    end

    def configure_player_symbol(player)
      choose_player_symbol(player)
    rescue
      io_interface.bad_input
      configure_player_symbol(player)  
    end

    def choose_player_symbol(player)
      if @symbols.size == 1
        player.symbol = @symbols.first
      else
        symbol = player.choose_symbol(SYMBOL_LIST)
        @symbols.delete(symbol)
      end
    end

    def configure_player_name(player)
      player.choose_name
    end

    def configure_player_strategy(player)
      player.choose_strategy(current_board)
    end
    
    def setup_and_draw_board
      io_interface.lets_play
      current_board.clean
      current_board.draw
    end

    def play_game(board)
      until board.someone_won_or_tied_game?
        player_move(player_1, player_2)
        @winner = player_1
        break if board.someone_won_or_tied_game?
        player_move(player_2, player_1)
        @winner = player_2
      end
    end

    def player_move(player, next_player)
      handle_players_choice(player, next_player)
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
      current_board.mark_position(choice, symbol)
      current_board.draw
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
      fail(Errors::PositionIsNotAvailable, 'Position is not available') unless current_board.is_position_available?(input.to_i)
    end

    def finish_game
      if current_board.tied_game?
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