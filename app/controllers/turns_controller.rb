class TurnsController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    lane_num = params.require(:turn)[:lane_number]
    user_id = params.require(:turn)[:user_id]
    turn = game.turns.new(lane_number: lane_num, user_id: user_id, game_id: game.id)
    turn.save!
    redirect_to game
  end
end
