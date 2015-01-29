# class BuildBoard
#   WIDTH = 7
#   HEIGHT = 6

#   def initialize(game)
#     @game = game
#   end

#   def call
#     grid = []
    
#     WIDTH.times {grid.push []}

#     @game.turns.each do |turn|
#       grid[turn.lane_number].push turn
#     end

#     board = Board.new(grid)
#   end
# end