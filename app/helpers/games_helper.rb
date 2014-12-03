module GamesHelper
  def current_player_name(game)
    game.whos_turn?.name
  end

  def item_for_slot(game, grid, lane, row)
    if row >= grid[lane].size
      "0"
    elsif grid[lane][row] == game.player_1_id
      "1"
    elsif grid[lane][row] == game.player_2_id
      "2"
    end
  end
end
