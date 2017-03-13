module CommandLineGames  
  class IOInterface
    def draw_board(board)
      output board_template(board)
    end

    def board_template(board)
      " #{board[0]} | #{board[1]} | #{board[2]} \n===+===+===\n #{board[3]} | #{board[4]} | #{board[5]} \n===+===+===\n #{board[6]} | #{board[7]} | #{board[8]} \n"
    end

    def show_input_options
      output "Enter [0-8]:"
    end

    def game_over_message
      output "Game over"
    end

    def bad_input
      output "Ops... Invalid input!"
    end

    def position_not_available
      output "Positions has already been chosen."
    end

    def choose_player_type
      output "Choose player type. H for human or C for computer:"
    end

    def choose_player_symbol
       output "Choose player symbol. X or O"
    end

    def player_turn(name)
      output "#{name} turn"
    end

    def for_player_1
      output "Player 1"
    end

    def for_player_2
      output "Player 2"
    end

    def waiting_for_input
      input
    end

    def output(content)
      puts content
    end

    def input
      gets.chomp
    end
  end
end