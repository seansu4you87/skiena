require_relative 'heap'

class Lego::PriorityQueue
  class Node
    attr_reader :key, :value

    def initialize(key, value)
      @key = key
      @value = value
    end

    def to_s
      "(#{key}, #{value})"
    end
  end

  def initialize(&blk)
    @dominator = blk || (lambda { |a, b| a.key < b.key })
    @heap = Lego::Heap.new(&@dominator)
  end

  def push(key, value = key)
    @heap.insert(Node.new(key, value))
  end

  def pop
    node = @heap.extract
    node.value
  end

  def peek
    @heap.peek.value
  end

  def to_s
    @heap.to_s
  end
end
