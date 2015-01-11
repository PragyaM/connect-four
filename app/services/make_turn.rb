class MakeTurn
  def initialize(lane_number, player, game)
    @lane_number = lane_number
    @player = player
    @game = game 
  end

  def call
    if @game.turns.select { |turn| turn.lane_number == @lane_number}.size < Game::GRID_HEIGHT
      turn = @game.turns.new(lane_number: @lane_number, player: @player, game: @game)
      turn.save
    else
      false
    end
  end
end