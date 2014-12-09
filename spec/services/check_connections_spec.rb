require "rails_helper"

RSpec.describe CheckConnections  do
  let(:grid) do 
    [[],[],[],[],[],[],[]]
  end
  
  let(:last_turn) {instance_double("Turn")}

  describe "#call" do
    context "when there are four in a row horizontally" do
      before do
        4.times do |lane|
          grid[lane].push(1)
        end

        expect(last_turn).to receive(:player_id).and_return 1
        expect(last_turn).to receive(:lane_number).and_return 3
      end
      
      let(:check_connections) {CheckConnections.new(grid, last_turn)}

      it "finds the match" do
        expect(check_connections.call).to be true
      end
    end

    context "when there are four in a row vertically" do
      before do
        4.times do
          grid[0].push(1)
        end

        expect(last_turn).to receive(:player_id).and_return 1
        expect(last_turn).to receive(:lane_number).and_return 0
      end
      
      let(:check_connections) {CheckConnections.new(grid, last_turn)}

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

        expect(last_turn).to receive(:player_id).and_return 1
        expect(last_turn).to receive(:lane_number).and_return 0
      end
      
      let(:check_connections) {CheckConnections.new(grid, last_turn)}

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

        expect(last_turn).to receive(:player_id).and_return 1
        expect(last_turn).to receive(:lane_number).and_return 0
      end
      
      let(:check_connections) {CheckConnections.new(grid, last_turn)}

      it "finds the match" do
        expect(check_connections.call).to be true
      end
    end

    context "when there are no linear connections of four or more coins" do
      before do
        grid[0].push(1)
        grid[2].push(0)
        grid[3].push(1)

        expect(last_turn).to receive(:player_id).and_return 1
        expect(last_turn).to receive(:lane_number).and_return 0
      end
      
      let(:check_connections) {CheckConnections.new(grid, last_turn)}

      it "finds the match" do
        expect(check_connections.call).to be false
      end
    end
  end
end