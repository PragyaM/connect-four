class Player < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  validates :user_id, :game_id, presence: true
  validates_uniqueness_of :user, scope: :game
  
  def opponent(game)
    game.player(1) == self ? game.player(2) : game.player(1)
  end
end
