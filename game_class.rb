require_relative 'piece_classes.rb'
require_relative 'board_class.rb'
require_relative 'human_class.rb'

class Game
  attr_accessor :end_game

  def initialize(white_player, black_player)
    @white = Human.new(:white, self)
    @black = Human.new(:black, self)
    @board = Board.new
    @turn = @white
    @end_game = false
  end

  def play


    until game_over
      reset_display

      begin

        start_pos, end_pos = @turn.get_input

        break if end_game == :draw

        @board.move(start_pos, end_pos)

      rescue ArgumentError => e

        puts "\nUh oh: #{e.message}\n"

        retry

      end

      @turn == @white ? @black : @white

    end

    reset_display

    if @board.check_mate?(:white)
      puts "\nCheckmate! Congratulations White!"
    elsif @board.check_mate?(:black)
      puts "\nCheckmate! Congratulations Black!"
    else
      puts "\nIt's a draw! Congratulations, you both wasted your time."
    end

  end

  private

  def reset_display
    puts "\e[H\e[2J"
    @board.display
  end

  def game_over
    @board.check_mate?(:white) ||
    @board.check_mate?(:black) ||
    @end_game == :draw
  end
end


if __FILE__ == $PROGRAM_NAME
  g = Game.new(Human, Human)
  g.play
end
