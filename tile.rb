require_relative "board"
require 'byebug'

class Tile
    attr_reader :revealed, :bomb, :flagged
    attr_writer :bomb

    # for debugging
    # def inspect
    #     "Position:   Bomb: #{bomb}  Revealed: #{revealed}   Flagged: #{flagged}\n"
    # end

    def initialize(board)
        @revealed = false
        @bomb = false
        @flagged = false
        @board = board
    end

    def reveal
        revealed = true
    end

    def toggle_flag
        flagged = !flagged
    end

    def to_s(position)
        return "F" if flagged
        return "B" if bomb
        check_square(position)
        # return "*" if !revealed
        # here's where we're going to want to display a number
    end

    def check_square(position)
        # not counting correctly
        # debugger
        value = 0
        x = (position[0] - 1) >= 0 ? (position[0] - 1) : position[0]

        while x <= (position[0] + 1)
            y = (position[1] - 1) >= 0 ? (position[1] - 1) : position[1]    
            while y <= (position[1] + 1)
                new_pos = [x, y]
                value += 1 if @board[new_pos].bomb
                break if (y + 1) > 8
                y += 1
            end
            break if (x + 1) > 8
            x += 1
        end

        value == 0 ? '_' : value
    end

    # pass board to Tile on initialize so you can find neighbors for
    # neighbors method and neighbor_bomb_count method

end