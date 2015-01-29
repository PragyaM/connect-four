class Turn < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  validates :lane_number, inclusion: {in: 0 ... Board::WIDTH}
  validate  :lane_is_not_full
  validate  :turns_alternate_between_players

  private

  def lane_is_not_full
    unless CheckSpaceInLane.new(game, lane_number).call
      errors.add(:lane_number, "doesn't have enough space")
    end
  end

  def turns_alternate_between_players
    if player_double_up?
      errors.add(:player_id, "cannot play twice in a row")
    end
  end

  def player_double_up?
    unless game.turns.size < 2
      game.turns[-2].player == game.turns.last.player
    end
  end
end
