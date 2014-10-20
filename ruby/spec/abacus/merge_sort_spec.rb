require 'spec_helper'

describe Abacus::MergeSort do
  describe '#sort' do
    subject { Abacus::MergeSort.sort(data) }

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

  describe '#split' do
    it "splits" do
      expect(Abacus::MergeSort.split [1]).to eql nil
      expect(Abacus::MergeSort.split []).to eql nil
      expect(Abacus::MergeSort.split [1, 2, 3, 4]).to eql [[1, 2], [3, 4]]
      expect(Abacus::MergeSort.split [1, 2, 3, 4, 5]).to eql [[1, 2, 3], [4, 5]]
    end
  end
end
