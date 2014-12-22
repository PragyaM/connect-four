require 'rails_helper'
require 'turn'

RSpec.describe Game, :type => :model do
  fixtures :games, :players, :turns
  let(:construct_board) { instance_double("ConstructBoard") }
  let(:game) { games(:playing_game) }
  let(:grid) { [[], [], [], [], [], [], []] }
  let(:last_turn_player_1) { turns(:last_turn_player1_lane3) }
  let(:last_turn_player_2) { turns(:last_turn_player_2) }

  describe "#active_player" do
    context "when no turns have been played yet" do
      before do
        allow(game).to receive(:turns).and_return []
      end
      it "is player 1's turn next" do
        expect(game.active_player).to be game.player(1)
      end
    end

    context "when the last turn was played by player 1" do
      before do
        allow(game).to receive(:turns).and_return [last_turn_player_1]
        # allow(game.player(2).to receive(:id).and_return 2
      end
      it "is player 2's turn next" do
        expect(game.active_player).to be game.player(2)
      end
    end

    context "when the last turn was played by player 2" do
      before do
        allow(game).to receive(:turns).and_return [last_turn_player_2]
        allow(game.player(1)).to receive(:id).and_return 1
      end
      it "is player 1's turn next" do
        expect(game.active_player).to be game.player(1)
      end
    end
  end
end
