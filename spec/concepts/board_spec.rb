require "rails_helper"

RSpec.describe Board do

  let(:game) { instance_double('Game') }
  let(:last_turn) { double('Turn') }
  let(:game_turns) { 3.times.collect{ last_turn } }
  let(:point) { instance_double('Point') }

  before do
    allow(game).to receive(:turns).at_least(1).times.and_return game_turns
    allow(last_turn).to receive(:lane_number).and_return 3
  end

  describe '#element_at' do
    let(:board) { Board.new(game: game) }

    context 'when there is an element at the given point' do
      it "returns the corresponding element in the grid" do
        allow(point).to receive(:column).and_return 3
        allow(point).to receive(:row).and_return 2
        expect(board.element_at(point)).to eq last_turn
      end
    end
    
    context 'when there is no element at the given point' do
      it "returns nil" do
        allow(point).to receive(:column).and_return 1
        allow(point).to receive(:row).and_return 2
        expect(board.element_at(point)).to eq nil
      end
    end
  end

  describe '#number_of_tokens_in_lane' do
    let(:board) { Board.new(game: game) }

    context 'when the given lane has 3 tokens in it' do
      it 'returns 3' do
        expect(board.number_of_tokens_in_lane(3)).to eq 3
      end
    end

    context 'when the given lane has 0 tokens in it' do
      it 'returns 0' do
        expect(board.number_of_tokens_in_lane(1)).to eq 0
      end
    end
  end

  describe '#out_of_bounds?' do
    let(:board) { Board.new(game: game) }

    context 'when the given point is outside the bounds of the board' do
      it 'returns true' do
        allow(point).to receive(:column).and_return (Board::WIDTH)
        allow(point).to receive(:row).and_return (3)
        expect(board.out_of_bounds?(point)).to be_truthy
      end

      it 'returns true' do
        allow(point).to receive(:column).and_return (3)
        allow(point).to receive(:row).and_return (Board::HEIGHT)
        expect(board.out_of_bounds?(point)).to be_truthy
      end

      it 'returns true' do
        allow(point).to receive(:column).and_return (-1)
        allow(point).to receive(:row).and_return (2)
        expect(board.out_of_bounds?(point)).to be_truthy
      end

      it 'returns true' do
        allow(point).to receive(:column).and_return (1)
        allow(point).to receive(:row).and_return (-1)
        expect(board.out_of_bounds?(point)).to be_truthy
      end
    end

    context 'when the given point is within the bounds of the board' do
      it 'returns false' do
        allow(point).to receive(:column).and_return (Board::WIDTH - 1)
        allow(point).to receive(:row).and_return (3)
        expect(board.out_of_bounds?(point)).to be_falsey
      end

      it 'returns false' do
        allow(point).to receive(:column).and_return (3)
        allow(point).to receive(:row).and_return (Board::HEIGHT - 1)
        expect(board.out_of_bounds?(point)).to be_falsey
      end

      it 'returns false' do
        allow(point).to receive(:column).and_return (2)
        allow(point).to receive(:row).and_return (2)
        expect(board.out_of_bounds?(point)).to be_falsey
      end

      it 'returns false' do
        allow(point).to receive(:column).and_return (0)
        allow(point).to receive(:row).and_return (0)
        expect(board.out_of_bounds?(point)).to be_falsey
      end
    end
  end

  describe '#token_at_position?' do
    let(:board) { Board.new(game: game) }

    context 'when there is a token at the given point in the grid' do
      it 'returns true' do
        allow(point).to receive(:column).and_return (3)
        allow(point).to receive(:row).and_return (1)
        expect(board.token_at_position?(point)).to be_truthy
      end
    end

    context 'when there is no token at the given point in the grid' do
      it 'returns false' do
        allow(point).to receive(:column).and_return (1)
        allow(point).to receive(:row).and_return (1)
        expect(board.token_at_position?(point)).to be_falsey
      end
    end

    context 'when the given point is out of the bounds of the grid' do
      it 'returns false' do
        allow(point).to receive(:column).and_return (-1)
        allow(point).to receive(:row).and_return (1)
        expect(board.token_at_position?(point)).to be_falsey
      end
    end
  end
end


