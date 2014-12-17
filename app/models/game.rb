class Game < ActiveRecord::Base
  GRID_WIDTH = 7
  GRID_HEIGHT = 6

  NUMBER_OF_PLAYERS = 2

  belongs_to :player_1, :class_name => 'User'
  belongs_to :player_2, :class_name => 'User'

  has_many :turns

  scope :not_waiting, -> {where(:player_2 != nil)}
  scope :waiting, -> {where(player_2: nil)}
  scope :not_completed, -> {where(finished: false)}
  scope :completed, -> {where(finished: true)}

  validate :player_1, presence: true
  validate :unique_players

  def space_in_lane?(lane_number)
    grid = ConstructBoard.new(self).call
    grid[lane_number].size <= GRID_HEIGHT
  end

  def current_player
    if turns.empty?
      player_1
    else
      last_player_id = turns.last.user_id
      last_player_id == player_1.id ? player_2 : player_1
    end
  end

  def winner
    winner_id = turns.last.user_id
    User.find(winner_id)
  end

  private

  def unique_players
    unless Game.waiting.include? self
      if player_1_id == player_2_id
        errors.add(:player_1, "cannot play against themself!")
      end
    end
  end
end
