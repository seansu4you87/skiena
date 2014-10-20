class BinarySearchTree
  attr_accessor :value, :left, :right, :parent

  def initialize(value, left, right)
    self.value = value
    self.left = left
    self.right = right
  end

  def left=(node)
    @left = node
    @left.parent = self if @left
  end

  def right=(node)
    @right= node
    @right.parent = self if @right
  end

  def to_s(values = nil, branches = nil)
    strings = print_each_node([self])
    strings.each_with_index do |str, i|
      spaces = " " * (strings.length - i - 1)
      strings[i] = "#{spaces}#{str}"
    end
    strings.join("\n")
  end

  def leaf?
    self.left.nil? && self.right.nil?
  end

  def children
    children = []
    children << self.left unless self.left.nil?
    children << self.right unless self.right.nil?
    children
  end

  def print_each_node(nodes, strings = nil)
    strings ||= []
    return strings if nodes.select{ |node| !node.nil? }.count == 0

    children = []
    node_strings = []
    branches = []
    nodes.each do |node|
      if !node.nil?
        children << node.left
        children << node.right
        node_strings << node.value.to_s
        branches << "/ \\"
      else
        node_strings << " "
        branches << "   "
      end
    end

    strings << node_strings.join("   ")
    strings << branches.join(" ")

    print_each_node(children, strings)
  end

  class << self
    def traverse(root, &blk)
      return if root.nil?

      traverse(root.left, &blk)
      blk.call(root.value)
      traverse(root.right, &blk)
    end

    def min(root)
      return root.value if root.left.nil?
      min(root.left)
    end

    def max(root)
      return root.value if root.right.nil?
      max(root.right)
    end

    def insert(root, value)
      if value < root.value
        if root.left.nil?
          node = BinarySearchTree.new(value, nil, nil)
          root.left = node
        else
          insert(root.left, value)
        end
      elsif value > root.value
        if root.right.nil?
          node = BinarySearchTree.new(value, nil, nil)
          root.right = node
        else
          insert(root.right, value)
        end
      else # if equal, insert to the right
        node = BinarySearchTree.new(value, nil, nil)
        old_right = root.right
        root.right = node
        node.right = old_right
        node
      end
    end

    def search(root, value)
      if value == root.value
        root
      elsif value < root.value
        search(root.left, value)
      elsif value > root.value
        search(root.right, value)
      end
    end

    def predecessor(root, value)
      node = search(root, value)
      if !node.left.nil?
        max(node.left)
      elsif !node.parent.nil?
        node.parent.value
      else
        nil
      end
    end

    def successor(root, value)
      node = search(root, value)
      if !node.right.nil?
        min(node.right)
      else
        nil
      end
    end

    def delete(root, value)
      if value == root.value
        if root.leaf?
          if root.parent.left == root
            root.parent.left = nil
          elsif root.parent.right == root
            root.parent.right = nil
          end
        elsif root.children.count == 1
          if root.parent.nil?
            if root.left.nil?
              root.value = root.right.value
              root.right = nil
            elsif root.right.nil?
              root.value = root.left.value
              root.left = nil
            end
          else
            if root.parent.left == root
              root.parent.left = root.left || root.right
            elsif root.parent.right == root
              root.parent.right = root.left || root.right
            end
          end
        elsif root.children.count == 2
          predecessor = root.left
          while predecessor.right != nil do
            predecessor = predecessor.right
          end

          root.value = predecessor.value
          delete(root.left, predecessor.value)
        end
      elsif value < root.value
        delete(root.left, value)
      elsif value > root.value
        delete(root.right, value)
      end
    end
  end

  # Dictionary implemented with a BinarySearchTree
  # Key will be the sorted index
  class Dictionary
    def initialize
      @_root = nil
      @_max = nil
      @_min = nil
    end

    # O(h)
    def search(k)
      count = 0
      BinarySearchTree.traverse(@_root) do |value|
        return value if count == k
        count += 1
      end
    end

    # O(h)
    def insert(x)
      if @_root == nil
        @_root = BinarySearchTree.new(x, nil, nil)
        @_max = x
        @_min = x
      else
        BinarySearchTree.insert(@_root, x)
        if x > @_max
          @_max = x
        end

        if x < @_min
          @_min = x
        end
      end
    end

    # O(h)
    def delete(x)
      BinarySearchTree.delete(@_root, x)
      @_max = BinarySearchTree.max(@_root)
      @_min = BinarySearchTree.min(@_root)
    end

    # O(1)
    def max
      @_max
    end

    # O(1)
    def min
      @_min
    end

    # O(h)
    def predecessor(x)
      BinarySearchTree.predecessor(@_root, x)
    end

    # O(h)
    def successor(x)
      BinarySearchTree.successor(@_root, x)
    end

    def to_s
      values = []
      BinarySearchTree.traverse(@_root) { |v| values << v }
      values.join " -> "
    end
  end
end
