require 'spec_helper'

describe Abacus::HeapSort do
  describe '#sort' do
    subject { Abacus::HeapSort.sort(data) }

    let(:data) { [4, 5, 2, 3, 1] }
    it "sorts!" do
      expect(subject).to eql [1, 2, 3, 4, 5]
    end

    context "already sorted" do
      let(:data) { [1, 2, 3, 4, 5] }
      it "sorts!" do
        expect(subject).to eql [1, 2, 3, 4, 5]
      end
    end

    context "all the same" do
      let(:data) { [1, 1, 1, 1, 1] }
      it "sorts!" do
        expect(subject).to eql [1, 1, 1, 1, 1]
      end
    end

    context "no data" do
      let(:data) { [] }
      it "returns empty" do
        expect(subject).to eql []
      end

      context "nil" do
        let(:data) { nil }
        it "returns empty" do
          expect(subject).to eql []
        end
      end
    end
  end
end
