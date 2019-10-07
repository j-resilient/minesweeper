require_relative 'board'

class Minesweeper
    attr_reader :board

    def initialize
        @board = Board.new
    end

    def run
        board.render
        input = get_input
        print input
        # check input for bomb
        # if not, update board
    end

    def get_input
        input = nil
        until input && valid_input?(input)
            input_prompt
            input = parse_input(gets.chomp.split(""))
        end
        input
    end

    def input_prompt
        puts "Please enter your move: type f (for flag) or r (for reveal) followed
        by the position you want to change. Example: r 0,0"
    end

    def parse_input(input)
        input.delete_if { |el| el == " " || el == ","}
        input.map do |el| 
            if el =~ /[[:digit:]]/
                el.to_i
            else
                el
            end
        end
    end

    def valid_input?(input)
        input.length == 3 &&
            (input[0] == 'r' || input[0] == 'f') &&
            (0..8).to_a.include?(input[1]) &&
            (0..8).to_a.include?(input[2])
    end
end

if __FILE__ == $PROGRAM_NAME
    game = Minesweeper.new
    game.run
end