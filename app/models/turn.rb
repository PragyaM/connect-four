class Turn < ActiveRecord::Base
  belongs_to :game

  validates :lane_number, :user_id, presence: true

  def validate(user_id)
    game.users.pluck(:id).include? user_id
  end

  def validate(lane_number)
    Game::GRID_WIDTH > lane_number && lane_number >= 0 &&
    game.space_in_lane?(lane_number)
  end
end
