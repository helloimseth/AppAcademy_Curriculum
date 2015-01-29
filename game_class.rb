require_relative 'piece_classes.rb'
require_relative 'board_class.rb'

class Game

  def initialize#(white_player, black_player)
  #   @white = white_player
  #   @black = black_player
    @board = Board.new
  end

  def play


    until @board.check_mate?(:white) || @board.check_mate?(:black)
      reset_display

      begin

        start_pos, end_pos = get_input

        @board.move(start_pos, end_pos)

      rescue ArgumentError => e

        puts "\nUh oh: #{e.message}\n"

        retry

      end

    end

    reset_display
    puts "Checkmate!"

  end

  def get_input    
    begin

      puts "Which piece would you like to move?"
      piece = parse_input(gets.chomp.downcase)

    rescue StandardError => e

      puts "#{e.message}"

      retry

    end

    begin

      puts "Where would you like to move it?"
      destination = parse_input(gets.chomp.downcase)

    rescue StandardError => e

      puts "#{e.message}"

      retry

    end

    [piece, destination]
  end

  def reset_display
    puts "\e[H\e[2J"
    @board.display
  end

  def parse_input(input)
    input_arr = input.split("")

    unless input_arr[0].match(/[abcdefgh]/) && input_arr[1].to_i.between?(1,8)
      raise StandardError.new "\nUh oh: Please enter in the form of Letter-Number, e.g. A5\n"
    end

    x_coord = input_arr[0].ord - 97
    y_coord = (input_arr[1].to_i - 8).abs

    [y_coord, x_coord]

  end

end


if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
