class TurnsController < ApplicationController
  before_action :load_game, only: [:index, :create]

  def create
    @lane_number = params.require(:turn)[:lane_number].to_i
    @player = Player.find(params.require(:turn)[:player_id])

    MakeTurn.new(@lane_number, @player, @game).call
    
    respond_to do |format|
      format.html do
        redirect_to(@game)
      end

      format.js do
        render :layout => false
      end
    end
  end

  private

  def load_game
    @game = Game.find(params[:game_id])
  end
end
