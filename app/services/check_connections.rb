class CheckConnections

  def initialize(grid, game)
    @grid = grid
    @game = game
    @last_turn = @game.turns.last
  end

  def call
    if @game.turns.size > 0
      @last_player_id = @last_turn.player_id

      @last_turn_x = @last_turn.lane_number
      @last_turn_y = @grid[@last_turn_x].size - 1

      horizontal_match? || vertical_match? || diagonal_down_match? || diagonal_up_match?
    else
      false
    end
  end

  private

  def horizontal_match?
    count = 0
    (Game::GRID_WIDTH).times do |lane|
      unless count >= 4
        @grid[lane][@last_turn_y] == @last_player_id ? count += 1 : count = 0
      end
    end

    count >= 4
  end

  def vertical_match?
    @grid[@last_turn_x].chunk do |ele| 
      ele == @last_player_id 
    end.detect do |last_player, array| 
      last_player && array.size >= 4
    end
  end

  def diagonal_down_match?
    if @last_turn_x < (Game::GRID_HEIGHT - 1 - @last_turn_y)
      @start_pt_x = 0
      @start_pt_y = @last_turn_y + @last_turn_x
      @path_length = Game::GRID_WIDTH - (Game::GRID_HEIGHT - @start_pt_y)

    elsif @last_turn_x > (Game::GRID_HEIGHT - 1 - @last_turn_y)
      @start_pt_x = @last_turn_x - (Game::GRID_HEIGHT - 1 - @last_turn_y)
      @start_pt_y = Game::GRID_HEIGHT - 1
      @path_length = Game::GRID_WIDTH - @start_pt_x

    else
      @start_pt_x = 0
      @start_pt_y = Game::GRID_HEIGHT - 1
      @path_length = Game::GRID_HEIGHT
    end

    if @path_length >= 4
      diagonal_match?(@path_length, @start_pt_x, @start_pt_y, 1, -1)
    else
      false
    end
  end

  def diagonal_up_match?
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

    if @path_length >= 4
      diagonal_match?(@path_length, @start_pt_x, @start_pt_y, 1, 1)
    else
      false
    end
  end

  def diagonal_match?(path_length, start_x, start_y, x_dir, y_dir)
    count = 0

    path_length.times do |steps|
      unless count >= 4
        if @grid[start_x + (x_dir * steps)][start_y + (y_dir * steps)] == @last_player_id
          count += 1
        else
          count = 0
        end
      end
    end

    count >= 4
  end
end