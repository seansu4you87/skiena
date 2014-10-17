require_relative "binary_search_tree"

describe BinarySearchTree do
  let(:to_s) do
    "      5"     \
    "\n     / \\" \
    "\n    3   6" \
    "\n   / \\"   \
    "\n  1   4"   \
    "\n   \\"     \
    "\n    2"     \
  end
#          5
#         / \
#        3   6
#       / \
#      1   4
#       \
#        2

  let(:six) { BinarySearchTree.new(6, nil, nil) }
  let(:five) { BinarySearchTree.new(5, three, six) }
  let(:four) { BinarySearchTree.new(4, nil, nil) }
  let(:three) { BinarySearchTree.new(3, one, four) }
  let(:two) { BinarySearchTree.new(2, nil, nil) }
  let(:one) { BinarySearchTree.new(1, nil, two) }
  let(:root) { five }

  describe "#to_s" do
    pending "prints out the tree" do
      expect(five.to_s).to eql to_s
    end
  end

  describe ".traverse" do
    it "iterates the tree" do
      values = []
      BinarySearchTree.traverse(root) { |v| values << v }
      expect(values).to eql [1, 2, 3, 4, 5, 6]
    end
  end

  describe ".insert" do
    it "inserts at the right spot" do
      five_2 = BinarySearchTree.insert(root, 5)
      expect(five.right).to eql five_2
      expect(five_2.right).to eql six

      nine = BinarySearchTree.insert(root, 9)
      expect(six.right).to eql nine

      eight = BinarySearchTree.insert(root, 8)
      expect(nine.left).to eql eight

      seven = BinarySearchTree.insert(root, 7)
      expect(eight.left).to eql seven
    end
  end

  describe ".search" do
    it "returns the node with the value" do
      expect(BinarySearchTree.search(root, 3)).to eql three
    end
  end

  describe ".min" do
    it "finds the minimum" do
      expect(BinarySearchTree.min(root)).to eql 1
    end
  end

  describe ".max" do
    it "finds the maximum" do
      expect(BinarySearchTree.max(root)).to eql 6
    end
  end

  describe ".predecessor" do
    it "finds the first value preceding" do
      expect(BinarySearchTree.predecessor(root, 5)).to eql 4
    end
  end

  describe ".successor" do
    it "finds the first value succeeding" do
      expect(BinarySearchTree.successor(root, 3)).to eql 4
    end
  end

  describe ".delete" do
#          5
#         / \
#        3   6
#       / \
#      1   4
#       \
#        2

    context "has children" do
      context "has one child" do
        it "deletes the node, takes the child, and replaces it" do
          BinarySearchTree.delete(root, 1)
          expect(three.left).to eql two
        end
      end

      context "has two children" do
        it "deletes correctly" do
          BinarySearchTree.delete(root, 3)
          expect(three.value).to eql 2
          expect(three.left).to eql one
        end

        it "deletes the root correctly" do
          BinarySearchTree.delete(root, 5)
          expect(five.value).to eql 4
        end
      end
    end

    context "leaf" do
      it "deletes the leaf" do
        BinarySearchTree.delete(root, 2)
        expect(one.right).to eql nil
      end
    end
  end

  describe BinarySearchTree::Dictionary do
    let(:dictionary) { BinarySearchTree::Dictionary.new }
    before do
      dictionary.insert 1
      dictionary.insert 2
      dictionary.insert 3
      dictionary.insert 4
    end

    describe "#search" do
      it "returns the value" do
        expect(dictionary.search 0).to eql 1
        expect(dictionary.search 1).to eql 2
        expect(dictionary.search 2).to eql 3
        expect(dictionary.search 3).to eql 4
      end
    end

    describe "#insert" do
      it "inserts the element into the dictionary" do
        dictionary.insert 5
        expect(dictionary.search 4).to eql 5
      end
    end

    describe "#delete" do
      it "deletes the element from the dictionary" do
        dictionary.delete 2
        expect(dictionary.to_s).to eql "1 -> 3 -> 4"
        dictionary.delete 4
        expect(dictionary.to_s).to eql "1 -> 3"
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
