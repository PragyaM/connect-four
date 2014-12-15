require 'rails_helper'
require 'turn'

RSpec.describe Game, :type => :model do
  fixtures :games, :users, :turns
  let(:construct_board) { instance_double("ConstructBoard") }
  let(:game) { games(:playing_game) }
  let(:grid) { [[], [], [], [], [], [], []] }
  let(:last_turn_player_1) { turns(:last_turn_player_1) }
  let(:last_turn_player_2) { turns(:last_turn_player_2) }

  describe "#space_in_lane?" do
    context "when the lane has room in it" do
      before do
        allow(ConstructBoard).to receive(:new).with(game).and_return construct_board
        allow(construct_board).to receive(:call).and_return grid
      end
      it "is true" do
        expect(game.space_in_lane?(1)).to be true
      end
    end

    context "when the lane is full" do
      before do
        (Game::GRID_HEIGHT - 1).times do
          grid[1].push(1)
        end
        allow(ConstructBoard).to receive(:new).with(game).and_return construct_board
        allow(construct_board).to receive(:call).and_return grid
      end
      it "is false" do
        expect(game.space_in_lane?(1)).to be false
      end
    end
  end

  describe "#current_player" do
    context "when no turns have been played yet" do
      before do
        allow(game).to receive(:turns).and_return []
      end
      it "is player 1's turn next" do
        expect(game.current_player).to be game.player_1
      end
    end

    context "when the last turn was played by player 1" do
      before do
        allow(game).to receive(:turns).and_return [last_turn_player_1]
        allow(game.player_2).to receive(:id).and_return 2
      end
      it "is player 2's turn next" do
        expect(game.current_player).to be game.player_2
      end
    end

    context "when the last turn was played by player 2" do
      before do
        allow(game).to receive(:turns).and_return [last_turn_player_2]
        allow(game.player_1).to receive(:id).and_return 1
      end
      it "is player 1's turn next" do
        expect(game.current_player).to be game.player_1
      end
    end
  end
end
