class Game < ActiveRecord::Base
  GRID_WIDTH = 7
  GRID_HEIGHT = 6

  NUMBER_OF_PLAYERS = 2

  has_many :turns

  belongs_to :player_1, :class_name => 'Player'
  belongs_to :player_2, :class_name => 'Player'

  validate :player_1_id, :player_2_id, presence: true

  scope :not_completed, -> {where(finished: false)}
  scope :completed, -> {where(finished: true)}

  #NOTE: This validation can be shifted to the database layer by making a table for uniting player-turns
        # See if this will be needed down the track

  def validate(turns)
    (turns.pluck(:player_id).uniq - player_1_id - player_2_id) <= 0
  end

  def winner?
  end

  def space_in_lane?(lane_number)
    (ConstructBoard.new(self).call)[lane_number].size < (GRID_HEIGHT - 1)
  end

  def whos_turn?
    if turns.empty?
      player_1
    else
      last_player_id = turns.last.player_id
      player_1_id == last_player_id ? player_2 : player_1
    end
  end
end
