class MakeTurn
  def initialize(lane_number, user_id, game)
    @lane_number = lane_number
    @user_id = user_id
    @game = game 
  end

  def call
    turn = @game.turns.new(lane_number: @lane_number, user_id: @user_id, game_id: @game.id)
    
    turn.save
  end
end