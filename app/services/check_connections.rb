class CheckConnections

  include Step

  def initialize(game, board)
    @game = game
    @last_turn = @game.turns.last
    @board = board
    @win_connections = []
  end

  def call
    begin
      @start_point = Point.new(@last_turn.lane_number, (@board.size_of_lane(@last_turn.lane_number)-1))

      Step::PATHS.each_value { |path| check_for_connections(path) }

      @win_connections.length > 0
    rescue
      false
    end
  end

  private

  def check_for_connections(path)
    @connected = [@start_point]

    check(path, Step::DIRECTIONS[:BACKWARD])

    if connect_four_found?
      @win_connections << @connected
    else

      check(path, Step::DIRECTIONS[:FORWARD])

      if connect_four_found?
        @win_connections << @connected
      end
    end
  end

  def check(path, direction)
    position = go(@start_point, path, direction)
    direction_traversal_finished = false

    until !@board.token_at_position?(position) || direction_traversal_finished do
      element_to_check = @board.element_at(position)

      if element_to_check.player == @last_turn.player
        add_position_to_connected(position, direction)
      else
        direction_traversal_finished = true
      end

      position = go(position, path, direction)
    end
  end

  def add_position_to_connected(position, direction)
    if direction == Step::DIRECTIONS[:FORWARD]
      @connected.push(position)
    else
      @connected.unshift(position)
    end
  end

  def connect_four_found?
    @connected.size >= 4
  end
end