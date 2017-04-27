module CommandLineGames
  module GameConfigurator
    SYMBOL_LIST = ["X","O"]

    def setup_player(player, number)
      configure_player(create_player(number))
    rescue Errors::BadInput
      io_interface.bad_input
      setup_player(player, number)
    end

    def create_player(number)
      @io_interface.for_player(number)
      create_player_by_type
    end

    def create_player_by_type
      type = handle_user_input_to_create_player
      Player.create_player(type, @io_interface)
    end

    def handle_user_input_to_create_player
      @io_interface.choose_player_type
      type = @io_interface.waiting_for_input
      fail(Errors::BadInput, 'Bad Input') unless type.upcase.match(/H|C/)
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
      if symbols.size == 1
        player.symbol = symbols.first
      else
        symbol = player.choose_symbol(SYMBOL_LIST)
        remove_symbol_from_list(symbol)
      end
    end

    def configure_player_name(player)
      player.choose_name
    end

    def configure_player_strategy(player)
      player.choose_strategy
    end
  end
end