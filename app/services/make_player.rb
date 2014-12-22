class MakePlayer
  def initialize (game, user)
    @game = game
    @user = user
  end

  def call
    player = Player.new(user_id: @user.id, game_id: @game.id)
    if player.save
      true
    elsif @game.players.pluck(:user_id).include? @user.id
      true
    else
      false
    end
  end
end