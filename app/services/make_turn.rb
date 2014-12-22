class MakeTurn
  def initialize(lane_number, player_id, game)
    @lane_number = lane_number
    @player_id = player_id
    @game = game 
  end

  def call
    if @game.turns.select { |turn| turn.lane_number == @lane_number}.size < Game::GRID_HEIGHT
      turn = @game.turns.new(lane_number: @lane_number, player_id: @player_id, game_id: @game.id)
      turn.save
    else
      false
    end
  end
end