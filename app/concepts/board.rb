class Board
  WIDTH = 7
  HEIGHT = 6

  attr_accessor :grid

  def initialize(game: game)
    @game = game
    @grid = []
    build_board_state
  end


  def element_at(point)
    @grid[point.x][point.y]
  end

  def size_of_lane(lane_number)
    @grid.fetch(lane_number).size
  end

  def out_of_bounds?(point)
    point.x >= WIDTH || point.x < 0 || point.y >= HEIGHT || point.y < 0
  end

  def token_at_position?(point)
    unless out_of_bounds?(point) || !element_at(point)
      size_of_lane(point.x) > 0
    else
      false
    end
  end

  private

  def build_board_state
    WIDTH.times {@grid.push []}

    @game.turns.each do |turn|
      @grid[turn.lane_number].push turn
    end
  end
end