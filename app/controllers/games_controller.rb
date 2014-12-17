class GamesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json do
        render json: {waiting_game_count: Game.waiting.size}
      end
    end
  end

  def show # GET /games/[id]
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html do
        @grid = ConstructBoard.new(@game).call
        if @game.turns.size > 0
          check_game_over
        end
      end

      format.json do
        render json: {my_turn: @game.current_player == current_user}
      end
    end
  end

  def create # POST /player_games
    unless Game.waiting.pluck(:player_1_id).include? current_user.id
      game = Game.create!(player_1: current_user)
    end
    redirect_to Game
  end

  def update # PUT /games/[id]
    game = Game.find(params[:id])
    if Game.waiting.include? game
      game.update!(id: params[:id], player_2: current_user)
    end
    redirect_to game
  end

  def destroy
    if Game.waiting.pluck(:player_1_id).include? current_user.id
      game = Game.find(params[:id])
      game.destroy
    end
    redirect_to Game
  end

  private

  def check_game_over
    if CheckConnections.new(@grid, @game.turns.last).call
      @game.finished = true
      @game.save!
    end
  end
end
