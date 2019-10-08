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
        pos_x, pos_y = position
        max_x, max_y = (pos_x + 1), (pos_y + 1)
        current_x = (pos_x - 1) >= 0 ? (pos_x - 1) : pos_x

        while current_x <= max_x
            current_y = (pos_y - 1) >= 0 ? (pos_y - 1) : pos_y 

            while current_y <= max_y
                new_pos = [current_x, current_y]
                surrounding_tiles << new_pos
                break if (current_y + 1) > @board.length
                current_y += 1
            end

            break if (current_x + 1) > 8
            current_x += 1
        end
        surrounding_tiles
    end

end