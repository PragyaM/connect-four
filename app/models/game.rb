class Game < ActiveRecord::Base
  GRID_WIDTH = 7
  GRID_HEIGHT = 6

  NUMBER_OF_PLAYERS = 2

  has_many :turns

  belongs_to :player_1, :class_name => 'Player'
  belongs_to :player_2, :class_name => 'Player'

  scope :not_completed, -> {where(finished: false)}
  scope :completed, -> {where(finished: true)}

  #NOTE: This validation can be shifted to the database layer by making a table for uniting player-turns
        # See if this will be needed down the track

  def validate(turns)
    (turns.pluck(:player_id).uniq - player_1.id - player_2.id) <= 0
  end

  def winner?
  end

  def room_in_lane?(lane_number)
  end
end
