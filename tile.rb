require_relative "board"
require 'colorize'

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
        @revealed = true
    end

    def toggle_flag
        @flagged = !flagged
    end

    def to_s(position)
        return "F".colorize(:green) if flagged
        return "*" if !revealed
        return "B".colorize(:red) if bomb
        neighbor_bomb_count(position)
    end

    def neighbor_bomb_count(position)
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

        value == 0 ? '_' : value.to_s.colorize(:blue)
    end

end