require_relative 'tile'

class Board
    attr_reader :grid

    def empty_grid
        tiles = Array.new(9) do
            Array.new(9) { Tile.new }
        end
    end

    def create_grid
        tiles = empty_grid
        positions = get_bombs_positions
        set_bombs(tiles, positions)
    end

    def get_bombs_positions
        pos = []
        until pos.length == 10
            x, y = rand(8), rand(8)
            pos << [x,y] if !pos.include?([x,y])
        end
        pos
    end

    def set_bombs(tiles, positions)
        positions.each do |pos|
            x,y = pos
            tiles[x][y].bomb = true
        end
        tiles
    end

    def initialize
        @grid = create_grid
    end

    def run
        render
    end

    def render
        puts "  #{(0..8).to_a.join(" ")}"
        grid.each_with_index do |row, row_idx|
            print "#{row_idx} #{row.map { |tile| tile.to_s }.join(" ")}\n"
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    board = Board.new
    board.run
end