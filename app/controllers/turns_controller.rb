class TurnsController < ApplicationController
  before_action :load_game, only: [:index, :create]

  def create
    lane_number = params.require(:turn)[:lane_number].to_i
    user_id = params.require(:turn)[:user_id]

    MakeTurn.new(lane_number, user_id, @game).call

    redirect_to @game
  end

  private

  def load_game
    @game = Game.find(params[:game_id])
  end
end
