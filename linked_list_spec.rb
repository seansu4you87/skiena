require_relative "linked_list"

describe LinkedList do
  let(:third) { LinkedList.new(3, nil) }
  let(:second) { LinkedList.new(2, third) }
  let(:first) { LinkedList.new(1, second) }
  let(:head) { first }

  describe "#to_s" do
    it "prints out all elements" do
      expect(head.to_s).to eql "1 -> 2 -> 3 -> nil"
    end
  end

  describe ".index" do
    it "finds the nth element" do
      expect(LinkedList.index(head, 0).value).to eql 1
      expect(LinkedList.index(head, 1).value).to eql 2
      expect(LinkedList.index(head, 2).value).to eql 3
      # expect(LinkedList.index(head, 3)).to raise_exception LinkedList::OutOfBoundsError
    end
  end

  describe ".search" do
    it "finds the node with the value" do
      expect(LinkedList.search(head, 5)).to eql nil
      expect(LinkedList.search(head, 2)).to eql second
    end
  end

  describe ".delete" do
    it "deletes the node, and returns the head" do
      expect(LinkedList.delete(head, second)).to eql head
      expect(head.to_s).to eql "1 -> 3 -> nil"
    end

    context "head" do
      it "deletes the head, and returns the new head" do
        expect(LinkedList.delete(head, head)).to eql second
        expect(head.to_s).to eql "1 -> nil"
        expect(second.to_s).to eql "2 -> 3 -> nil"
      end
    end

    context "tail" do
      it "deletes the head, and returns the head" do
        expect(LinkedList.delete(head, third)).to eql head
        expect(head.to_s).to eql "1 -> 2 -> nil"
      end
    end

    context "not in list" do
      it "returns nil" do
        expect(LinkedList.delete(head, LinkedList.new(5, nil))).to eql nil
      end
    end
  end

  describe ".reverse" do
    it "reverses" do
      expect(LinkedList.reverse(head).to_s).to eql "3 -> 2 -> 1 -> nil"
    end
  end

  describe LinkedList::Dictionary do
    let(:dictionary) { LinkedList::Dictionary.new }
    before do
      dictionary.insert 1
      dictionary.insert 2
      dictionary.insert 3
      dictionary.insert 4
    end

    describe "#search" do
      it "returns the value" do
        expect(dictionary.search 0).to eql 4
        expect(dictionary.search 1).to eql 3
        expect(dictionary.search 2).to eql 2
        expect(dictionary.search 3).to eql 1
      end
    end

    describe "#insert" do
      it "inserts the element into the dictionary" do
        dictionary.insert 5
        expect(dictionary.search 0).to eql 5
      end
    end

    describe "#delete" do
      it "deletes the element from the dictionary" do
        dictionary.delete 2
        expect(dictionary.to_s).to eql "4 -> 3 -> 1 -> nil"
        dictionary.delete 4
        expect(dictionary.to_s).to eql "3 -> 1 -> nil"
      end
    end

    describe "#max" do
      it "gets the maximum value" do
        dictionary.insert(-1)
        expect(dictionary.max).to eql 4
        dictionary.delete(4)
        expect(dictionary.max).to eql 3
      end
    end

    describe "#min" do
      it "gets the minimum value" do
        dictionary.insert(5)
        expect(dictionary.min).to eql 1
        dictionary.delete(1)
        expect(dictionary.min).to eql 2
      end
    end

    describe "#predecessor" do
      it "finds the item whose key is immediately before" do
        expect(dictionary.predecessor 4).to eql 3
        expect(dictionary.predecessor 1).to eql nil
        dictionary.insert 1
        expect(dictionary.predecessor 1).to eql nil
      end
    end

    describe "#successor" do
      it "finds the item whose key is immediately before" do
        expect(dictionary.successor 1).to eql 2
        expect(dictionary.successor 4).to eql nil
      end
    end
  end
end
