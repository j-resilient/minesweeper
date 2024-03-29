require_relative 'board'
require 'byebug'

class Minesweeper
    attr_reader :board, :current_input

    def initialize
        @board = Board.new
        @current_input = []
    end

    def run
        until game_over?
            board.render
            current_input = get_input
            board.update(current_input)
        end
        board.reveal_all
        puts "Game over!"
    end

    def game_over?
        board.win? || board.lose?
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
        input.map! do |el| 
            if el =~ /[[:digit:]]/
                el.to_i
            else
                el
            end
        end
        input[1], input[2] = input[2], input[1]
        input
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