class GamesController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        @user = current_user
        @accepted_games = @user.recently_accepted_games
        @resumable_games = @user.resumable_games
        @joinable_games = @user.joinable_games
        @finished_games = @user.finished_games
      end

      format.json do
        render json: {pending_game_count: Game.pending.size}
      end
    end
  end

  def show # GET /games/[id]
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html do
        @active_player = @game.active_player
        @grid = ConstructBoard.new(@game).call
        check_game_over 
      end

      format.json do
        render json: {my_turn: @game.active_player.user == current_user}
      end
    end
  end

  def create # POST /games
    unless current_user.pending_game_exists?
      game = Game.create!
      if game.save
        Player.create(game_id: game.id, user: current_user)
      end
    end
    redirect_to games_path
  end

  def destroy
    game = Game.find(params[:id])
    if current_user.pending_game == game
      game.destroy
    end
    redirect_to games_path
  end

  private

  def check_game_over
    if CheckConnections.new(@grid, @game).call
      @game.finished = true
      @game.save!
    end
  end
end
