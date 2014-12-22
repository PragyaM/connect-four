class ConstructBoard
  def initialize(game)
    @game = game
  end

  def call
    grid = []
    (Game::GRID_WIDTH).times {grid.push []}
    @game.turns.each do |turn|
      grid[turn.lane_number].push turn.player_id
    end

    grid
  end
end