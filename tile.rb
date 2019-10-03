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

    def to_s
        return "F" if flagged
        return "*" if !revealed
        return "B" if bomb
        # here's where we're going to want to display a number
    end
end