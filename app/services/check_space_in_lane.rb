class CheckSpaceInLane
  def initialize(game, lane_number)
    @game = game
    @lane_number = lane_number
  end

  def call
    if coins_in_lane <= Game::GRID_HEIGHT
      true
    else
      false
    end
  end

  private

  def coins_in_lane
    @game.turns.select { |turn| turn.lane_number == @lane_number }.size
  end
end