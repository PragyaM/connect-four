class Player < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  validates :user_id, :game_id, presence: true
  validates_uniqueness_of :user, scope: :game

end
