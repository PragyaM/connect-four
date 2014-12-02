class Turn < ActiveRecord::Base
  # has_one :player  FIXME: Not sure if I need this?
  belongs_to :game

  validates :lane_number, :player_id, presence: true

  def validate(player_id)
    game.players.pluck(:id).include? player_id
  end

  def validate(lane_number)
    Game::GRID_WIDTH > lane_number && lane_number >= 0
  end

  def validate(game)
    game.room_in_lane?(lane_number)
  end
end
