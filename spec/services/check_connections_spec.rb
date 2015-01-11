require "rails_helper"

RSpec.describe CheckConnections  do
  let(:grid) do 
    [[],[],[],[],[],[],[]]
  end

  fixtures :games, :turns, :players, :users
  let(:horizontal_win_game) { games(:horizontal_win_game) }
  let(:vertical_win_game) { games(:vertical_win_game) }
  let(:diagonal_up_win_game) { games(:diagonal_up_win_game) }
  let(:diagonal_down_win_game) { games(:diagonal_down_win_game) }
  let(:horizontal_player) { players(:player_horizontal_win) }
  let(:vertical_player) { players(:player_vertical_win) }
  let(:diagonal_up_player) { players(:player_diagonal_up_win) }
  let(:diagonal_up_opponent) { players(:opponent_diagonal_up_win) }
  let(:diagonal_down_player) { players(:player_diagonal_down_win) }
  let(:diagonal_down_opponent) { players(:opponent_diagonal_down_win) }

  describe "#call" do
    context "when there are four in a row horizontally" do
      before do
        4.times do |lane|
          grid[lane].push(horizontal_player)
        end
      end

      let(:check_connections) {CheckConnections.new(grid, horizontal_win_game)}

      it "finds the match" do
        # expect(turns(:horizontal_4)).to be false
        expect(check_connections.call).to be_truthy
      end
    end

    context "when there are four in a row vertically" do
      before do
        4.times do
          grid[0].push(vertical_player)
        end
      end

      it "finds the match" do
        expect(CheckConnections.new(grid, vertical_win_game).call).to be_truthy
      end
    end

    context "when there are four in a row diagonally upwards" do
      before do
        4.times do |lane|
          lane.times do
            grid[lane].push("diagonal_up_opponent")
          end
          grid[lane].push("diagonal_up_player")
        end
      end
      
      let(:check_connections) {CheckConnections.new(grid, diagonal_up_win_game)}

      it "finds the match" do
        expect(check_connections.call).to be_truthy
      end
    end

    context "when there are four in a row diagonally downwards" do
      before do
        4.times do |lane|
          (3 - lane).downto(1) do
            grid[lane].push(diagonal_down_opponent)
          end
          grid[lane].push(diagonal_down_player)
        end
      end
      
      let(:check_connections) {CheckConnections.new(grid, diagonal_down_win_game)}

      it "finds the match" do
        expect(check_connections.call).to be_truthy
      end
    end

    context "when there are no linear connections of four or more coins" do
      before do
        grid[3].push(diagonal_down_player)
        grid[4].push(diagonal_down_opponent)
        grid[5].push(diagonal_down_player)
        grid[6].push(diagonal_down_opponent)
      end
      
      let(:check_connections) {CheckConnections.new(grid, diagonal_down_win_game)}

      it "finds no match" do
        expect(check_connections.call).to be false
      end
    end
  end
end