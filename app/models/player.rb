class Player < ActiveRecord::Base
  validates :name, presence: true
  # validates :name, uniqueness: {scope: :id, message: "should be unique to each player"}
end
