module GamesHelper
  def current_player_name(game)
    game.whos_turn?.name
  end
end
