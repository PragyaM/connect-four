class TurnsController < ApplicationController
  before_action :load_game, only: [:index, :create]

  def create
    lane_number = params.require(:turn)[:lane_number].to_i
    player_id = params.require(:turn)[:player_id]
    puts player_id

    MakeTurn.new(lane_number, player_id, @game).call
    
    redirect_to @game
  end

  private

  def load_game
    @game = Game.find(params[:game_id])
  end
end
