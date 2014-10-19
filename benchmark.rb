require 'benchmark'

require_relative 'linked_list'
require_relative 'binary_search_tree'
require_relative 'heap'
require_relative 'priority_queue'

def benchmark_data_structure(klass, sizes, methods, opts = {})
  ds = {}

  build_method = opts[:build_method] || :insert

  sizes.each do |size|
    d = klass.new
    ds[d] = size
  end

  ds.each do |d, size|
    (1...size).to_a.shuffle.each do |i|
      d.send(build_method, i)
    end
  end

  Benchmark.bm 30 do |bm|
    methods.each do |key, value|
      blk, big_o = value
      title = "#{key.ljust 15} #{big_o}"

      benchmark_data_structure_method(bm, title, ds, &blk)
    end
  end
end

def benchmark_data_structure_method(bm, title, ds, &blk)
  puts "\n"
  puts title
  puts "\n"
  ds.each do |d, size|
    bm.report format_number(size).rjust(20) do
      blk.call(d, size)
    end
  end
end

def format_number(number)
  number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
end

# BENCHMARK!!!

dictionary_methods = {
  "Insert"      => (lambda { |d, size| d.insert (size/2) }),
  "Search"      => (lambda { |d, size| d.search (size/2) }),
  "Delete"      => (lambda { |d, size| d.delete (size/2) }),
  "Maximum"     => (lambda { |d, size| d.max }),
  "Minimum"     => (lambda { |d, size| d.min }),
  "Predecessor" => (lambda { |d, size| d.predecessor (size/2) }),
  "Successor"   => (lambda { |d, size| d.successor (size/2) }),
}

linked_list_big_o = {
  "Insert"      => "O(1)",
  "Search"      => "O(n)",
  "Delete"      => "O(n)",
  "Maximum"     => "O(1)",
  "Minimum"     => "O(1)",
  "Predecessor" => "O(n)",
  "Successor"   => "O(n)",
}

binary_search_tree_big_o = {
  "Insert"      => "O(h)",
  "Search"      => "O(n) =[",
  "Delete"      => "O(h)",
  "Maximum"     => "O(1)",
  "Minimum"     => "O(1)",
  "Predecessor" => "O(h)",
  "Successor"   => "O(h)",
}

sizes = [
  10,
  100,
  1_000,
  10_000,
  100_000,
  1_000_000,
  # 10_000_000,
]

# benchmark_data_structure(
#   LinkedList::Dictionary,
#   sizes,
#   dictionary_methods.merge(linked_list_big_o) { |key, old, new| [old, new] }
# )

# benchmark_data_structure(
#   BinarySearchTree::Dictionary,
#   sizes,
#   dictionary_methods.merge(binary_search_tree_big_o) { |key, old, new| [old, new] }
# )

heap_methods = {
  "Insert"  => [(lambda { |d, size| d.insert (size/2) }), "O(h)"],
  "Extract" => [(lambda { |d, size| d.extract }),         "O(h)"],
}
# benchmark_data_structure(Heap, sizes, heap_methods)

priority_queue_methods = {
  "Push" => [(lambda { |d, size| d.push (size/2) }), "O(h)"],
  "Pop"  => [(lambda { |d, size| d.pop }),           "O(h)"],
  "Peek" => [(lambda { |d, size| d.peek }),          "O(1)"],
}
benchmark_data_structure(PriorityQueue, sizes, priority_queue_methods, build_method: :push)
