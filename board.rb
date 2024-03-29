require_relative 'tile'
require 'byebug'

class Board
    attr_reader :grid, :bomb_positions

    def [](position)
        x, y = position
        grid[x][y]
    end

    def length
        @grid.length
    end

    def get_bomb_positions
        positions = []
        until positions.length == 10
            x, y = rand(8), rand(8)
            positions << [x,y] if !positions.include?([x,y])
        end
        positions
    end

    def create_grid
        tiles = Array.new(9) do
            Array.new(9) { Tile.new(self) }
        end
        set_bombs(tiles)
    end

    def set_bombs(tiles)
        bomb_positions.each do |pos|
            x,y = pos
            tiles[x][y].bomb = true
        end
        tiles
    end

    def initialize
        @bomb_positions = get_bomb_positions
        @grid = create_grid
        @lose = false
    end

    def render
        puts "  #{(0..8).to_a.join(" ")}"
        grid.each_with_index do |row, row_idx|
            puts "#{row_idx} #{ row.map.with_index { |tile, col_idx| tile.to_s([row_idx, col_idx]) }.join(' ') }"
        end
    end

    def reveal_all
        @grid.each do |row|
            row.each { |tile| tile.reveal }
        end
        render
    end

    def update(input)
        x, y = input[1], input[2]
        if input[0] == 'f'
            grid[x][y].toggle_flag
        else
            if grid[x][y].bomb
                @lose = true
            else
                reveal_input(x,y)
            end
        end
    end

    def reveal_input(x, y)
        grid[x][y].reveal
        grid[x][y].reveal_neighbors([x,y]) if grid[x][y].to_s([x,y]) == '_'
    end

    def lose?
        @lose
    end

    def win?
        @grid.flatten.all? { |tile| tile.revealed && !tile.bomb }
    end
end