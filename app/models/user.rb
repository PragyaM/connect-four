class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :players, dependent: :destroy

  def games
    players.map { |player| player.game }
  end

  def pending_game_exists?
    games.select { |game| game.pending? }.size > 0
  end

  def pending_game
    games.select { |game| game.pending? }.first
  end

  def joinable_games
    Game.pending.reject { |game| playing? game }
  end

  def finished_games
    games.select { |game| game.finished? }.select do |game|
      playing? game
    end
  end

  def resumable_games
    (continuing_games - recently_accepted_games).select do |game|
      playing? game
    end
  end

  def recently_accepted_games
    continuing_games.select do |game|
      game.turns.size == 0 && self == game.player(1).user
    end
  end

  private

  def continuing_games
    games.reject {|game| game.finished?} - games.select {|game| game.pending?}
  end

  def playing?(game)
    game.players.any? { |player| players.include? player }
  end
end
