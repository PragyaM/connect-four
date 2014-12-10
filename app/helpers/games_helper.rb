module GamesHelper
  def current_player_name(game)
    game.current_player.name
  end

  def resource_for_slot(game, grid, lane, row)
    if row >= grid[lane].size
      "empty.png"
    elsif grid[lane][row] == game.player_1_id
      "better_coin_pink.png"
    elsif grid[lane][row] == game.player_2_id
      "better_coin_green.png"
    end
  end

  def winner_name(game)
    winner_id = game.turns.last.user_id
    User.find(winner_id).name
  end
end
