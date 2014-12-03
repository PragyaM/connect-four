class TurnsController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    lane_num = params.require(:turn)[:lane_number]
    player_id = params.require(:turn)[:player_id]
    turn = game.turns.new(lane_number: lane_num, player_id: player_id, game_id: game.id)
    turn.save!
    redirect_to game
  end
end
