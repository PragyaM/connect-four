class PlayersController < ApplicationController

  def create
    @game = Game.find(params[:game_id])
    if MakePlayer.new(@game, current_user).call
      redirect_to @game
    else
      redirect_to games_path
    end
  end
end
