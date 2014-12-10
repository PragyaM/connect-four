class Player < ActiveRecord::Base
  validates :name, presence: true
  # FIXME: Not sure if this is needed.. validates :name, uniqueness: {scope: :id, message: "should be unique to each player"}
end
