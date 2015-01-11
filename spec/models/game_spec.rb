require 'rails_helper'
require 'turn'

RSpec.describe Game, :type => :model do
  fixtures :games, :players, :turns
  let(:construct_board) { instance_double("ConstructBoard") }
  let(:playing_game) { games(:playing_game) }
  let(:finished_game) { games(:finished_game) }
  let(:pending_game) { games(:pending_game) }
  let(:grid) { [[], [], [], [], [], [], []] }
  let(:last_turn_player_1) { turns(:last_turn_player1_lane3) }
  let(:last_turn_player_2) { turns(:last_turn_player_2) }
  let(:winner) { players(:ernie_playing_against_bert) }
  let(:winner_turn) { turns(:winning_turn_player_2) }

  describe "#active_player" do
    context "when no turns have been played yet" do
      it "is player 1's turn next" do
        expect(playing_game.active_player).to eq playing_game.player(1)
      end
    end

    context "when the last turn was played by player 2" do
      before do
      end
      it "is player 1's turn next" do
        expect(playing_game.active_player).to eq playing_game.player(1)
      end
    end
  end

  describe "#winner" do
    context "when game is finished" do
      before do
      end

      it "is the last player to have played a turn" do
        expect(finished_game.winner).to eq winner
      end
    end

    context "when the game is not yet finished" do
      it "there is no winner" do
        expect(playing_game.winner).to be nil
      end
    end
  end

  describe "#pending?" do
    context "when the game is waiting for one more player" do
      it "is pending" do
        expect(pending_game.pending?).to be true
      end
    end

    context "when the game has enough players" do
      it "is not pending" do
        expect(playing_game.pending?).to be false
      end
    end
  end
end



