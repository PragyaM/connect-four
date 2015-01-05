class MakeGame
  def initialize(user)
    @user = user
  end

  def call
    unless @user.pending_game_exists?
      player = Player.new(user: @user, game: Game.create!)
      player.save ? true : false
    else
      false
    end
  end
end