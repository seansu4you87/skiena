require 'spec_helper'

describe Lego::Heap do
  describe '#insert' do
    it "inserts" do
      h = Lego::Heap.new
      h.insert 5  # 5
      h.insert 3  # 5, 3 -> 3, 5
      h.insert 4  # 3, 5, 4
      h.insert 20 # 3, 5, 4, 20
      h.insert 1  # 3, 5, 4, 20, 1 -> 3, 1, 4, 20, 5 -> 1, 3, 4, 20, 5
      expect(h.to_s).to eql "1, 3, 4, 20, 5"
    end
  end

  describe "#extract" do
    it "extracts the most dominant member" do
      h = Lego::Heap.new
      expect(h.extract).to eql nil

      h.insert 5
      h.insert 3
      h.insert 4
      h.insert 20
      h.insert 1  # 1, 3, 4, 20, 5
      h.insert 36 # 1, 3, 4, 20, 5, 36

      expect(h.extract).to eql 1
      expect(h.to_s).to eql "3, 5, 4, 20, 36"
    end
  end
end
