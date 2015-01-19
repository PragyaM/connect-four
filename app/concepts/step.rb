module Step

  PATHS = {
    :VERTICAL => {"x" => 0, "y" => 1},
    :HORIZONTAL => {"x" => 1, "y" => 0},
    :SLOPE_UP => {"x" => 1, "y" => 1},
    :SLOPE_DOWN => {"x" => 1, "y" => -1}
  }
  

  DIRECTIONS = {
    :FORWARD => 1,
    :BACKWARD => -1
  }

  def go(point, path, direction)
    x = point.x + (path.fetch("x") * direction)
    y = point.y + (path.fetch("y") * direction)

    Point.new(x, y)
  end

end