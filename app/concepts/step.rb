module Step

  PATHS = {
    :VERTICAL => {:row_offset => 0, :column_offset => 1}, #FIXME row_offset, column_offset
    :HORIZONTAL => {:row_offset => 1, :column_offset => 0},
    :SLOPE_UP => {:row_offset => 1, :column_offset => 1},
    :SLOPE_DOWN => {:row_offset => 1, :column_offset => -1}
  }
  

  DIRECTIONS = {
    :FORWARD => 1,
    :BACKWARD => -1
  }

  def go(point, path, direction)
    column = point.column + (path.fetch(:row_offset) * direction)
    row = point.row + (path.fetch(:column_offset) * direction)

    Point.new(column, row)
  end

end