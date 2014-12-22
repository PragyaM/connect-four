class Game < ActiveRecord::Base
  GRID_WIDTH = 7
  GRID_HEIGHT = 6

  has_many :players, dependent: :destroy
  has_many :turns, dependent: :destroy

  scope :not_pending, -> {where(:players.size == 2)}
  scope :pending, -> {where(:players.size == 1)}
  scope :not_completed, -> {where(finished: false)}
  scope :completed, -> {where(finished: true)}

  validate :correct_number_of_players

  def active_player
    if turns.empty?
      player(1)
    else
      turns.last.player == player(1) ? player(2) : player(1)
    end
  end

  def winner
    turns.last.player if finished?
  end

  def pending?
    players.size == 1
  end

  def player(number)
    if players.size >= number
      players[number - 1]
    end
  end

  def opponent(active_user)
    if players.pluck(:user_id).include? active_user.id
      players.select { |player| player.user != active_user }.first
    end
  end

  private

  def correct_number_of_players
    players.size <= 2 && players.size >= 0
  end
end
