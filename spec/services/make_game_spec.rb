require "rails_helper"

RSpec.describe MakeGame  do
  fixtures :games, :users, :players
  let(:user) {users(:ernie)}
  let(:user_with_pending_game) {users(:bert)}
  let(:game) {games(:pending_game)}
  let(:player) {players(:bert_waiting_for_opponent)}

  describe "#call" do
    context "when the user sends an invitation out" do
      context "and the user does not already have a pending game" do
        let(:make_game) {MakeGame.new(user)}

        it "creates a new game" do
          expect{make_game.call}.to change{Game.count}.by 1
        end
      end

      context "and the user already has a pending game" do
        let(:make_game) {MakeGame.new(user_with_pending_game)}

        it "creates a new game" do
          expect{make_game.call}.to change{Game.count}.by 0
        end
      end
    end
  end
end