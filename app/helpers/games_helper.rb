module GamesHelper

  def turn_info(game)
    "It is #{player_for_turn(game)} turn"
  end

  def game_over_text(game)
    if game.winner.user == current_user
      "You won!"
    else
      "Game over. #{game.winner.user.name} has connected four."
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
    if game.player(1).id == player_id
      "pink_coin.png"
    elsif game.player(2).id == player_id
      "silver_coin.png"
    else
      "empty.png"
    end
  end

  def finished_game_text(game)
    game.winner.user == current_user ? "Won against #{opponent_name(game)}" : "Lost against #{opponent_name(game)}"
  end

  def opponent_name(game)
    game.opponent(current_user).user.name
  end

  private

  def player_for_turn(game)
    game.active_player.user == current_user ? "your" : "#{game.active_player.user.name}'s"
  end
end
