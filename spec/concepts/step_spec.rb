require "rails_helper"

RSpec.describe Step do
  let(:dummy_class) { Object.new.extend(Step) }
  let(:point) { instance_double('Point') }

  describe '#go' do
    context "when stepping vertical forward from (2, 3)" do
      before do
        allow(point).to receive(:x).and_return 2
        allow(point).to receive(:y).and_return 3
      end
      it "returns new position (2, 4)" do
        expect(Point).to receive(:new).with(2, 4)
        dummy_class.go(point, Step::PATHS.fetch(:VERTICAL), Step::DIRECTIONS.fetch(:FORWARD))
      end
    end

    context "when stepping vertical backward from (2, 3)" do
      before do
        allow(point).to receive(:x).and_return 2
        allow(point).to receive(:y).and_return 3
      end
      it "returns new position (2, 2)" do
        expect(Point).to receive(:new).with(2, 2)
        dummy_class.go(point, Step::PATHS.fetch(:VERTICAL), Step::DIRECTIONS.fetch(:BACKWARD))
      end
    end

    context "when stepping horizontal forward from (2, 3)" do
      before do
        allow(point).to receive(:x).and_return 2
        allow(point).to receive(:y).and_return 3
      end
      it "returns new position (3, 3)" do
        expect(Point).to receive(:new).with(3, 3)
        dummy_class.go(point, Step::PATHS.fetch(:HORIZONTAL), Step::DIRECTIONS.fetch(:FORWARD))
      end
    end

    context "when stepping horizontal backward from (2, 3)" do
      before do
        allow(point).to receive(:x).and_return 2
        allow(point).to receive(:y).and_return 3
      end
      it "returns new position (1, 3)" do
        expect(Point).to receive(:new).with(1, 3)
        dummy_class.go(point, Step::PATHS.fetch(:HORIZONTAL), Step::DIRECTIONS.fetch(:BACKWARD))
      end
    end

    context "when stepping slope up forward from (2, 3)" do
      before do
        allow(point).to receive(:x).and_return 2
        allow(point).to receive(:y).and_return 3
      end
      it "returns new position (3, 4)" do
        expect(Point).to receive(:new).with(3, 4)
        dummy_class.go(point, Step::PATHS.fetch(:SLOPE_UP), Step::DIRECTIONS.fetch(:FORWARD))
      end
    end

    context "when stepping slope up backward from (2, 3)" do
      before do
        allow(point).to receive(:x).and_return 2
        allow(point).to receive(:y).and_return 3
      end
      it "returns new position (1, 2)" do
        expect(Point).to receive(:new).with(1, 2)
        dummy_class.go(point, Step::PATHS.fetch(:SLOPE_UP), Step::DIRECTIONS.fetch(:BACKWARD))
      end
    end

    context "when stepping slope down forward from (2, 3)" do
      before do
        allow(point).to receive(:x).and_return 2
        allow(point).to receive(:y).and_return 3
      end
      it "returns new position (3, 2)" do
        expect(Point).to receive(:new).with(3, 2)
        dummy_class.go(point, Step::PATHS.fetch(:SLOPE_DOWN), Step::DIRECTIONS.fetch(:FORWARD))
      end
    end

    context "when stepping slope down backward from (2, 3)" do
      before do
        allow(point).to receive(:x).and_return 2
        allow(point).to receive(:y).and_return 3
      end
      it "returns new position (1, 4)" do
        expect(Point).to receive(:new).with(1, 4)
        dummy_class.go(point, Step::PATHS.fetch(:SLOPE_DOWN), Step::DIRECTIONS.fetch(:BACKWARD))
      end
    end
  end

end