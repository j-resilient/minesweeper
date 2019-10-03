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
        print @grid
    end

    def run
        print grid
    end
end

if __FILE__ == $PROGRAM_NAME
    board = Board.new
    # board.run
end