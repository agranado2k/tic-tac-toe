module CommandLineGames  
  class IOInterface
    def introduction
      output "##################################################"
      output "############    Tic Tac Toe    ###################"
      output "#### by Command Lines Games Inc. - March/2017 ####"
      output "##################################################"
      output ""
      output "Enter q any time to exit."
      output ""
    end
    
    def draw_board(board)
      output board_template(board)
    end

    def board_template(board)
      " #{board[0]} | #{board[1]} | #{board[2]} \n===+===+===\n #{board[3]} | #{board[4]} | #{board[5]} \n===+===+===\n #{board[6]} | #{board[7]} | #{board[8]} \n"
    end

    def show_input_options
      output "Enter [0-8]:"
    end


    def bad_input
      output "Ops... Invalid input!"
    end

    def position_not_available
      output "Positions has already been chosen."
    end

    def choose_player_type
      output "Choose player's type. H for human or C for computer:"
    end

    def choose_player_strategy
      output "Difficulty level"
      output "(E)asy - (M)edium - (H)ard [default is M]:"
    end

    def choose_player_symbol
       output "Choose player's symbol. X or O"
    end

    def choose_player_name
      output "Choose player's name"
    end

    def player_setup(position, name, symbol)
      output ""
      output "Player #{position} - #{name} (#{symbol})"
    end

    def lets_play
      output ""
      output "Let's play! \\0/"
      output ""
    end

    def player_turn(name, symbol)
      output "#{name} (#{symbol}) turn"
    end

    def for_player(number)
      output "Player #{number}"
    end

    def show_tied_game_message
      output "Tied Game! Nobody wins! :("
    end

    def winner_message(name, symbol)
      output "Player #{name} (#{symbol}) wins!!! =)"
    end

    def game_over_message
      output "Game over"
    end

    def waiting_for_input
      input
    end

    def output(content)
      puts content
    end

    def input
      tmp_input = gets.chomp
      quit_game if tmp_input.upcase.match(/Q/)
      tmp_input
    end

    def quit_game
      output "Bye bye!"
      exit(true)
    end
  end
end