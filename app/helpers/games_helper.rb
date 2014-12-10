module GamesHelper
  def resource_for_slot(game, grid, lane, row)
    if row >= grid[lane].size
      "empty.png"
    elsif grid[lane][row] == game.player_1_id
      "purple_coin.png"
    elsif grid[lane][row] == game.player_2_id
      "blue_coin.png"
    end
  end

  def games_in_progress?(user)
    Game.not_waiting.pluck(user.id).size > 0 &&
    Game.not_waiting.pluck(user.id).any? { |game| Game.not_completed.include? game }
  end

  def turn_info_text(game)
    "It is #{current_player_name_for_turn_info(game)} turn"
  end

  def game_over_text(game)
    if winner(game) == current_user
      "You won!"
    else
      "Game over. #{winner(game).name} has connected four."
    end
  end

  private

  def current_player_name_for_turn_info(game)
    game.current_player == current_user ? "your" : "#{game.current_player.name}'s"
  end

  def winner(game)
    winner_id = game.turns.last.user_id
    User.find(winner_id)
  end
end
