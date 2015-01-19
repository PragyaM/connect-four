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
        if direction == Step::DIRECTIONS[:FORWARD]
          @connected.push(position)
        else
          @connected.unshift(position)
        end
      else
        direction_traversal_finished = true
      end

      position = go(position, path, direction)
    end
  end

  def connect_four_found?
    @connected.size >= 4
  end


  # def initialize(grid, game)
  #   @grid = grid
  #   @game = game
  #   @last_turn = @game.turns.last
  # end

  # def call
  #   if @game.turns.size > 0
  #     @last_player = @last_turn.player

  #     @last_turn_x = @last_turn.lane_number
  #     @last_turn_y = @grid[@last_turn_x].size - 1

  #     fill_spaces

  #     horizontal_match? || vertical_match? || diagonal_down_match? || diagonal_up_match?
  #   else
  #     false
  #   end
  # end

  # private

  # def fill_spaces
  #   @grid.map! do |lane|  
  #     Game::GRID_HEIGHT.downto(lane.size) do
  #       lane.push(nil)
  #     end
  #     lane
  #   end
  # end

  # def horizontal_match?
  #   grid_to_check = @grid.transpose
  #   match?(grid_to_check, @last_turn_y)
  # end

  # def vertical_match?
  #   match?(@grid, @last_turn_x)
  # end

  # def diagonal_up_match?
  #   grid_to_check = diagonal_transpose(@grid, Game::GRID_WIDTH, Game::GRID_HEIGHT)
  #   column_to_check = @last_turn_x + (Game::GRID_HEIGHT - @last_turn_y)

  #   match?(grid_to_check, column_to_check)
  # end

  # def diagonal_down_match?
  #   transposed_grid = @grid.transpose
  #   grid_to_check = diagonal_transpose(transposed_grid, Game::GRID_HEIGHT, Game::GRID_WIDTH)
  #   column_to_check = @last_turn_x + @last_turn_y - 1

  #   puts "  original"
  #   print_grid(@grid)
  #   puts "  transposed"
  #   print_grid(transposed_grid)
  #   puts "  diagonal"
  #   print_grid(grid_to_check)

  #   match?(grid_to_check, column_to_check)
  # end

  # def print_grid(grid)
  #   grid.size.downto(0) do |row|
  #     row_output = []
  #     Game::GRID_WIDTH.times do |column|
  #       row_output << (grid[column][row].present? ? 'O' : ' ')
  #     end
  #     puts row_output.join("|")
  #   end
  # end

  # def diagonal_transpose(grid_to_transpose, width, height)
  #   (-height).upto(width).map do |column_number|
  #     column = height.times.collect{ |i| grid_to_transpose[i][i - column_number] }
  #     if column_number > 0
  #       column = column.drop(column_number)
  #     end
  #     column
  #   end
  # end

  # def match?(checkable_grid, last_turn_row)
  #   checkable_grid[last_turn_row].chunk do |ele| 
  #     begin
  #       ele.player == @last_player
  #     rescue
  #       false
  #     end
  #   end.any? do |last_player, array|
  #     last_player && array.size >= 4
  #   end
  # end
end