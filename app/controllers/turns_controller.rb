class TurnsController < ApplicationController
  before_action :load_game, only: [:index, :create]

  def create
    @lane_number = params.require(:turn)[:lane_number].to_i
    @player = Player.find(params.require(:turn)[:player_id])

    MakeTurn.new(@lane_number, @player, @game).call
    
    redirect_to @game
  end

  private

  def load_game
    @game = Game.find(params[:game_id])
  end
end
