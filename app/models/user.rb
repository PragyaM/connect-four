class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def waiting_game_exists?
    Game.waiting.pluck(:player_1_id).include? id
  end

  def waiting_game
    Game.waiting.detect { |game| game.player_1 == self }
  end

  def joinable_games
    Game.waiting.select do |game|
      game.player_1 != self
    end
  end

  def finished_games
    Game.completed.select do |game|
      playing? game
    end
  end

  def resumable_games
    (Game.not_completed - Game.waiting - recently_accepted_invitations).select do |game|
      playing? game
    end
  end

  def opponent(game)
    game.player_1 == self ? game.player_2 : game.player_1
  end

  def recently_accepted_invitations
    (Game.not_completed - Game.waiting).select do |game|
      game.turns.size == 0 && self == game.player_1
    end
  end

  private

  def playing?(game)
    game.player_1 == self || game.player_2 == self
  end
end
