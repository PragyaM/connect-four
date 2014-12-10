class GamesController < ApplicationController
  def show # GET /games/[id]
    @game = Game.find(params[:id])
    @grid = ConstructBoard.new(@game).call
    if @game.turns.size > 0
      if CheckConnections.new(@grid, @game.turns.last).call
        @game.finished = true
        @game.save!
        #TODO Disable interaction with the game grid
      end
    end
  end

  def create # POST /player_games
    game = Game.create!(player_1: current_user)
    redirect_to game
  end

  def update # PUT /games/[id]
    game = Game.find(params[:id])

    game.update!(id: params[:id], player_2: current_user)

    redirect_to game
  end
end
