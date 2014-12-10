class GamesController < ApplicationController
  def show # GET /games/[id]
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html do
        @grid = ConstructBoard.new(@game).call
        if @game.turns.size > 0
          if CheckConnections.new(@grid, @game.turns.last).call
            @game.finished = true
            @game.save! #FIXME: THIS IS BAD
          end
        end
      end

      format.json do
        render json: {my_turn: @game.current_player == current_user}
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
