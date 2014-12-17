module GamesHelper

  def turn_info(game)
    "It is #{player_for_turn(game)} turn"
  end

  def game_over_text(game)
    if game.winner == current_user
      "You won!"
    else
      "Game over. #{winner(game).name} has connected four."
    end
  end

  def resource_for_slot(game, grid, lane, row)
    if row >= grid[lane].size
      "empty.png"
    else
      resource_for_player(game, grid[lane][row])
    end
  end

  def resource_for_player(game, player_id)
    if game.player_1_id == player_id
      "pink_coin.png"
    elsif game.player_2_id == player_id
      "silver_coin.png"
    else
      "empty.png"
    end
  end

  private

  def player_for_turn(game)
    game.current_player == current_user ? "your" : "#{game.current_player.name}'s"
  end
end
