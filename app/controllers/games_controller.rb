class GamesController < ApplicationController
  def show # GET /games/[id]
    @game = Game.find(params[:id])
    @grid = ConstructBoard.new(@game).call
  end

  def create # POST /games
    game = Game.create!
    redirect_to game
  end
end
