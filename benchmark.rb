require 'benchmark'

require_relative 'linked_list'
require_relative 'binary_search_tree'
require_relative 'heap'
require_relative 'priority_queue'

class Analysis
  class Method
    attr_reader :name, :big_o, :blk

    def initialize(name, big_o, &blk)
      @name = name
      @big_o = big_o
      @blk = blk
    end
  end

  def initialize(klass, creation_big_o, &creation_blk)
    @klass = klass

    @creation_method = Method.new("Creation", creation_big_o, &creation_blk)
    @methods = []
  end

  def <<(method)
    @methods << method
  end

  def run(sizes, method_name = nil)
    ds = {}
    sizes.each do |size|
      d = @klass.new
      ds[d] = size
    end

    Benchmark.bm 30 do |bm|
      run_method(@creation_method, ds, bm)
      @methods.each { |method| run_method(method, ds, bm) }
    end
  end

  def run_method(method, ds, bm)
    puts "\n#{method.name.ljust 15} #{method.big_o}\n\n"
    ds.each do |d, size|
      bm.report(format_size(size)) { method.blk.call(d, size) }
    end
  end

  private

  def format_size(size)
    size.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.rjust(20)
  end
end

# BENCHMARK!!!

ll = Analysis.new(LinkedList::Dictionary, "O(n)") do |d, size|
  (1...size).to_a.shuffle.each { |i| d.insert i }
end

ll << Analysis::Method.new("Insert", "O(1)") { |d, size| d.insert (size/2) }
ll << Analysis::Method.new("Search", "O(n)") { |d, size| d.search (size/2) }
ll << Analysis::Method.new("Delete", "O(n)") { |d, size| d.delete (size/2) }
ll << Analysis::Method.new("Maximum", "O(1)") { |d, size| d.max }
ll << Analysis::Method.new("Minimum", "O(1)") { |d, size| d.min }
ll << Analysis::Method.new("Predecessor", "O(n)") { |d, size| d.predecessor (size/2) }
ll << Analysis::Method.new("Successor", "O(n)") { |d, size| d.successor (size/2) }
# ll.run [
#   10,
#   100,
#   1_000,
#   10_000,
#   100_000,
#   1_000_000,
#   10_000_000,
# ]

bst = Analysis.new(BinarySearchTree::Dictionary, "O(n logn)") do |d, size|
  (1...size).to_a.shuffle.each { |i| d.insert i }
end
bst << Analysis::Method.new("Insert", "O(h)") { |d, size| d.insert (size/2) }
bst << Analysis::Method.new("Search", "O(n) =[, could be better") { |d, size| d.search (size/2) }
bst << Analysis::Method.new("Delete", "O(h)") { |d, size| d.delete (size/2) }
bst << Analysis::Method.new("Maximum", "O(1)") { |d, size| d.max }
bst << Analysis::Method.new("Minimum", "O(1)") { |d, size| d.min }
bst << Analysis::Method.new("Predecessor", "O(h)") { |d, size| d.predecessor (size/2) }
bst << Analysis::Method.new("Successor", "O(h)") { |d, size| d.successor (size/2) }
# bst.run [
#   10,
#   100,
#   1_000,
#   10_000,
#   100_000,
#   # 1_000_000, # takes 8 seconds
#   # 10_000_000, # takes like 7 fucking minutes!
# ]

h = Analysis.new(Heap, "O(n logn) ???") do |d, size|
  (1...size).to_a.shuffle.each { |i| d.insert i }
end
h << Analysis::Method.new("Insert", "O(h)") { |d, size| d.insert (size/2) }
h << Analysis::Method.new("Extract", "O(h)") { |d, size| d.extract }
h.run [
  10,
  100,
  1_000,
  10_000,
  100_000,
  # 1_000_000,
  # 10_000_000, # 27 seconds
  # 100_000_000, # 4.5 minutes (270 seconds)
]


pq = Analysis.new(PriorityQueue, "O(n logn) ???") do |d, size|
  (1...size).to_a.shuffle.each { |i| d.push i }
end
pq << Analysis::Method.new("Push", "O(h)") { |d, size| d.push (size/2) }
pq << Analysis::Method.new("Pop", "O(h)") { |d, size| d.pop }
pq << Analysis::Method.new("Peek", "O(1)") { |d, size| d.peek }
# pq.run [
#   10,
#   100,
#   1_000,
#   10_000,
#   100_000,
#   1_000_000,
#   10_000_000,
# ]

sizes = [
  10,
  100,
  1_000,
  10_000,
  100_000,
  1_000_000,
  # 10_000_000, # 26 seconds
  # 100_000_000, # ???
]

# method_name = "Insert"
# ll.run(sizes, method_name)
# bst.run(sizes, method_name)
