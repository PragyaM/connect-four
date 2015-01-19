require "rails_helper"

RSpec.describe CheckConnections do

  let(:board) { instance_double('Board') }

  let(:last_turn) { instance_double(Turn) }
  let(:opponent_turn) { instance_double(Turn) }
  let(:game) { instance_double(Game) }
  let(:game_turns) { 10.times.collect{ last_turn } }
  let(:winner) { instance_double(Player) }

  def print_grid(grid)
    Game::GRID_HEIGHT.downto(0) do |row|
      row_output = []
      Game::GRID_WIDTH.times do |column|
        row_output << (grid[column][row].present? ? 'O' : ' ')
      end
      puts row_output.join("|")
    end
  end

  describe "#call" do
    context "when there are four in a row horizontally" do
      before do
        4.times do |lane|
          grid[lane].push last_turn
        end

        allow(opponent_turn).to receive(:player).at_least(1).times.and_return winner
        allow(last_turn).to receive(:player).at_least(1).times.and_return winner
        allow(game).to receive(:turns).at_least(1).times.and_return game_turns
        allow(last_turn).to receive(:lane_number).and_return 3
      end

      let(:check_connections) {CheckConnections.new(grid, game)}

      it "finds the match" do
        expect(check_connections.call).to be_truthy
      end
    end

    context "when there are four in a row vertically" do
      before do
        4.times do
          grid[0].push last_turn
        end

        allow(opponent_turn).to receive(:player).at_least(1).times.and_return winner
        allow(last_turn).to receive(:player).at_least(1).times.and_return winner
        allow(game).to receive(:turns).at_least(1).times.and_return game_turns
        allow(last_turn).to receive(:lane_number).and_return 0
      end

      it "finds the match" do
        expect(CheckConnections.new(grid, game).call).to be_truthy
      end
    end

    context "when there are four in a row diagonally upwards" do
      before do
        4.times do |lane|
          lane.times do
            grid[lane].push opponent_turn
          end
          grid[lane].push last_turn   
        end       

        allow(opponent_turn).to receive(:player).at_least(1).times.and_return winner
        allow(last_turn).to receive(:player).at_least(1).times.and_return winner
        allow(game).to receive(:turns).at_least(1).times.and_return game_turns
        allow(last_turn).to receive(:lane_number).and_return 1
      end
      
      let(:check_connections) {CheckConnections.new(grid, game)}

      it "finds the match" do
        expect(check_connections.call).to be_truthy
      end
    end

    context "when there are four in a row diagonally downwards" do
      before do
        4.times do |lane|
          (4 - lane).times do
            grid[lane].push opponent_turn
          end
          grid[lane].push last_turn   
        end       
        print_grid(grid)

        allow(opponent_turn).to receive(:player).at_least(1).times.and_return winner
        allow(last_turn).to receive(:player).at_least(1).times.and_return winner
        allow(game).to receive(:turns).at_least(1).times.and_return game_turns
        allow(last_turn).to receive(:lane_number).and_return 3
      end
      
      let(:check_connections) {CheckConnections.new(grid, game)}

      it "finds the match" do
        expect(check_connections.call).to be_truthy
      end
    end

    context "when there are no linear connections of four or more coins" do
      before do 
        3.times do |lane|
          grid[lane].push last_turn
        end

        allow(opponent_turn).to receive(:player).at_least(1).times.and_return winner
        allow(last_turn).to receive(:player).at_least(1).times.and_return winner
        allow(game).to receive(:turns).at_least(1).times.and_return game_turns
        allow(last_turn).to receive(:lane_number).and_return 1
      end
      
      let(:check_connections) {CheckConnections.new(grid, game)}

      it "finds no match" do
        expect(check_connections.call).to be_falsey
      end
    end
  end
end