class CheckConnections
  def initialize(grid, last_turn)
    @grid = grid
    @last_turn = last_turn
  end

  def call
    @last_player_id = @last_turn.player_id

    @last_turn_x = @last_turn.lane_number
    @last_turn_y = @grid[@last_turn_x].size - 1

    horizontal_match? || vertical_match? || diagonal_down_match? || diagonal_up_match?
  end

  def horizontal_match?
    count = 0
    (Game::GRID_WIDTH).times do |lane|
      unless count >= 4
        if @grid[lane][@last_turn_y] == @last_player_id
          count += 1

        else
          count = 0
        end
      end
    end

    count >= 4
  end

  def vertical_match?
    count = 0
    (Game::GRID_HEIGHT).times do |row|
      unless count >= 4
        if @grid[@last_turn_x][row] == @last_player_id
          count += 1
        else
          count = 0
        end
      end
    end

    count >= 4
  end

  def diagonal_down_match?
    count = 0
    if @last_turn_x < (Game::GRID_HEIGHT - @last_turn_y)
      @start_pt_x = 0
      @start_pt_y = Game::GRID_HEIGHT - (@last_turn_y - @last_turn_x)
      @path_length = Game::GRID_HEIGHT - @start_pt_y
    elsif @last_turn_x > @last_turn_y
      @start_pt_x = @last_turn_x - @last_turn_y
      @start_pt_y = 0
      @path_length = Game::GRID_WIDTH - @start_pt_x
    else
      @start_pt_x = 0
      @start_pt_y = 0
      @path_length = Game::GRID_HEIGHT
    end

    @path_length.times do |steps|
      unless count >= 4
        if @grid[@start_pt_x + steps][@start_pt_y + steps] == @last_player_id
          count += 1
        else
          count = 0
        end
      end
    end

    count >= 4
  end

  def diagonal_up_match?
    count = 0
    if @last_turn_x < @last_turn_y
      @start_pt_x = 0
      @start_pt_y = @last_turn_y - @last_turn_x
      @path_length = Game::GRID_HEIGHT - @start_pt_y
    elsif @last_turn_x > @last_turn_y
      @start_pt_x = @last_turn_x - @last_turn_y
      @start_pt_y = 0
      @path_length = Game::GRID_WIDTH - @start_pt_x
    else
      @start_pt_x = 0
      @start_pt_y = 0
      @path_length = Game::GRID_HEIGHT
    end

    @path_length.times do |steps|
      unless count >= 4
        if @grid[@start_pt_x + steps][@start_pt_y + steps] == @last_player_id
          count += 1
        else
          count = 0
        end
      end
    end

    count >= 4
  end
end