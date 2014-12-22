require "rails_helper"

RSpec.describe CheckConnections  do
  let(:grid) do 
    [[],[],[],[],[],[],[]]
  end

  fixtures :games, :turns
  let(:game) { games(:playing_game) }
  
  let(:last_turn_lane_3) { turns(:last_turn_player1_lane3) }
  let(:last_turn_lane_0) { turns(:last_turn_player1_lane0) }

  describe "#call" do
    context "when there are four in a row horizontally" do
      before do
        4.times do |lane|
          grid[lane].push(1)
        end

        expect(last_turn_lane_3).to receive(:player).and_return 1
        expect(last_turn_lane_3).to receive(:lane_number).and_return 3
      end
      
      let(:check_connections) {CheckConnections.new(grid, game)}

      it "finds the match" do
        expect(check_connections.call).to be true
      end
    end

    context "when there are four in a row vertically" do
      before do
        4.times do
          grid[0].push(1)
        end

        allow(game.turns).to receive(:size).and_return 4
        expect(last_turn_lane_0).to receive(:player).and_return 1
        expect(last_turn_lane_0).to receive(:lane_number).and_return 0
      end
      
      let(:check_connections) {CheckConnections.new(grid, game)}

      it "finds the match" do
        expect(check_connections.call).to be true
      end
    end

    context "when there are four in a row diagonally upwards" do
      before do
        4.times do |lane|
          lane.times do
            grid[lane].push(0)
          end
          grid[lane].push(1)
        end

        expect(last_turn_lane_0).to receive(:player).and_return 1
        expect(last_turn_lane_0).to receive(:lane_number).and_return 0
      end
      
      let(:check_connections) {CheckConnections.new(grid, game)}

      it "finds the match" do
        expect(check_connections.call).to be true
      end
    end

    context "when there are four in a row diagonally downwards" do
      before do
        4.times do |lane|
          lane.downto(0) do
            grid[lane].push(0)
          end
          grid[lane].push(1)
        end

        expect(last_turn_lane_0).to receive(:player).and_return 1
        expect(last_turn_lane_0).to receive(:lane_number).and_return 0
      end
      
      let(:check_connections) {CheckConnections.new(grid, game)}

      it "finds the match" do
        expect(check_connections.call).to be true
      end
    end

    context "when there are no linear connections of four or more coins" do
      before do
        grid[0].push(1)
        grid[2].push(0)
        grid[3].push(1)
      end
      
      let(:check_connections) {CheckConnections.new(grid, game)}

      it "finds the match" do
        expect(check_connections.call).to be false
      end
    end
  end
end