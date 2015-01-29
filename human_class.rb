class Human

  def initialize(color, game)
    @game = game
    @color = color
  end

  def get_input
    begin

      puts "Which piece would you like to move?"
      piece = parse_input(gets.chomp.downcase)

    rescue StandardError => e

      puts "#{e.message}"

      retry

    end

    return nil if @game.end_game == :draw

    begin

      puts "Where would you like to move it?"
      destination = parse_input(gets.chomp.downcase)

    rescue StandardError => e

      puts "#{e.message}"

      retry

    end

    [piece, destination]
  end


  def parse_input(input)
    input_arr = input.split("")

    if input.downcase == "draw"
      @game.end_game = :draw
      return nil
    end

    unless input_arr[0].match(/[abcdefgh]/) && input_arr[1].to_i.between?(1,8)
      raise StandardError.new "\nUh oh: Please enter in the form of Letter-Number, e.g. A5\n"
    end

    x_coord = input_arr[0].ord - 97
    y_coord = (input_arr[1].to_i - 8).abs

    [y_coord, x_coord]

  end
end
