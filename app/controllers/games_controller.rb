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
        render json: {pending_game_count: Game.pending.length}
      end
    end
  end

  def show # GET /games/[id]
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html do
        @active_player = @game.active_player
        @board = Board.new(game: @game)
        check_game_over
      end

      format.json do
        render json: {my_turn: @game.active_player.user == current_user}
      end
    end
  end

  def create # POST /games
    MakeGame.new(current_user).call
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
    if CheckConnections.new(@game, @board).call
      @game.finished = true
      @game.save!
    end
  end
end
