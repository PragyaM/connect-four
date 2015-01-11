module GamesHelper


  def message_for_turn(game)
    if game.finished
      game_over_text(game)
    else
      "It is #{player_for_turn(game)} turn"
    end
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
      "empty_orange.png"
    else
      resource_for_player(game, grid[lane][row])
    end
  end

  def resource_for_player(game, player)
    if game.player(1) == player
      "green_coin.png"
    elsif game.player(2) == player
      "pink_coin.png"
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

  def my_turn?(game)
    game.active_player.user == current_user
  end

  def my_turn_and_game_not_over?(game)
    my_turn?(game) && !game.finished?
  end

  private

  def player_for_turn(game)
    my_turn?(game) ? "your" : "#{game.active_player.user.name}'s"
  end
end
