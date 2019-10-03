class Tile
    attr_reader :revealed, :bomb, :flagged

    # for debugging
    def inspect
        "Position: \n Bomb: #{bomb}\n Revealed: #{self.revealed?}\n Flagged: #{flagged}"
    end

    def initialize(bomb)
        @revealed = false
        @bomb = bomb
        @flagged = false
    end

    def reveal
        revealed = true
    end

    def toggle_flag
        flagged = !flagged
    end
end