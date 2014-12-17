class Turn < ActiveRecord::Base
  belongs_to :game

  validates :lane_number, :user_id, presence: true
  validates :lane_number, inclusion: {in: 0 ... Game::GRID_WIDTH}
  validate  :lane_is_not_full
  validate  :player_is_part_of_game
  validate  :turns_alternate_between_players

  private

  def lane_is_not_full
    unless game.space_in_lane?(lane_number)
      errors.add(:lane_number, "This lane doesn't have enough space")
    end
  end

  def player_is_part_of_game
    unless player_in_game?
      errors.add(:user_id, "This isn't your game to play!")
    end
  end

  def turns_alternate_between_players
    if player_double_up?
      errors.add(:user_id, "You cannot play twice in a row")
    end
  end

  def player_double_up?
    if game.turns.size > 1
      game.turns.last(2).first.user_id == game.turns.last.user_id 
    end
  end

  def player_in_game?
    game.player_1.id == user_id || game.player_2.id == user_id
  end
end
