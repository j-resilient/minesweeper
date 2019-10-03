class Tile
    attr_reader :revealed, :bomb, :flagged
    attr_writer :bomb

    # for debugging
    def inspect
        "Position:   Bomb: #{bomb}  Revealed: #{revealed}   Flagged: #{flagged}\n"
    end

    def initialize
        @revealed = false
        @bomb = false
        @flagged = false
    end

    def reveal
        revealed = true
    end

    def toggle_flag
        flagged = !flagged
    end
end