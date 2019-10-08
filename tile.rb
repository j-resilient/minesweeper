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
        bomb_count = 0
        get_surrounding_tiles(position).each { |pos| bomb_count += 1 if @board[pos].bomb }
        bomb_count == 0 ? '_' : bomb_count.to_s.colorize(:blue)
    end

    def get_surrounding_tiles(position)
        surrounding_tiles = []
        x = (position[0] - 1) >= 0 ? (position[0] - 1) : position[0]

        while x <= (position[0] + 1)
            y = (position[1] - 1) >= 0 ? (position[1] - 1) : position[1]    
            while y <= (position[1] + 1)
                new_pos = [x, y]
                surrounding_tiles << new_pos
                break if (y + 1) > 8
                y += 1
            end
            break if (x + 1) > 8
            x += 1
        end
        surrounding_tiles
    end

end