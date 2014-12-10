class Game < ActiveRecord::Base
  GRID_WIDTH = 7
  GRID_HEIGHT = 6

  NUMBER_OF_PLAYERS = 2

  has_many :turns

  belongs_to :player_1, :class_name => 'User'
  belongs_to :player_2, :class_name => 'User'

  validate :player_1, presence: true

  scope :not_waiting, -> {where(:player_1, :player_2, presence: true)}
  scope :waiting, -> {where(player_2: nil)}

  scope :not_completed, -> {where(finished: false)}
  scope :completed, -> {where(finished: true)}

  def validate(turns)
    (turns.pluck(:player_id).uniq - player_1_id - player_2_id) <= 0
  end

  def space_in_lane?(lane_number)
    grid = ConstructBoard.new(self).call
    grid[lane_number].size < (GRID_HEIGHT - 1)
  end

  def current_player
    if turns.empty?
      player_1
    else
      last_player_id = turns.last.user_id
      last_player_id == player_1.id ? player_2 : player_1
    end
  end
end
