class Board
  WIDTH = 7
  HEIGHT = 6

  attr_reader :grid

  def initialize(game: game)
    @game = game
    @grid = []
    build_board_state
  end

  def element_at(point)
    @grid[point.column][point.row]
  end

  def number_of_tokens_in_lane(lane_number)
    @grid.fetch(lane_number).size
  end

  def out_of_bounds?(point)
    point.column >= WIDTH || point.column < 0 || point.row >= HEIGHT || point.row < 0
  end

  def token_at_position?(point)
    unless out_of_bounds?(point) || !element_at(point)
      number_of_tokens_in_lane(point.column) > 0
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