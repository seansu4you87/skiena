require 'benchmark'

require_relative 'linked_list'
require_relative 'binary_search_tree'

def benchmark_dictionary(klass, sizes, big_o)
  ds = {}

  sizes.each do |size|
    d = klass.new
    ds[d] = size
  end

  ds.each do |d, size|
    (1...size).to_a.shuffle.each do |i|
      d.insert i
    end
  end

  Benchmark.bm 30 do |bm|
    benchmark_dictionary_method(bm, "Insert      #{big_o['Insert']}", ds) { |d, size| d.insert size/2 }
    benchmark_dictionary_method(bm, "Search      #{big_o['Search']}", ds) { |d, size| d.search (size/2) }
    benchmark_dictionary_method(bm, "Delete      #{big_o['Delete']}", ds) { |d, size| d.delete (size/2) }
    benchmark_dictionary_method(bm, "Maximum     #{big_o['Maximum']}", ds) { |d, size| d.max }
    benchmark_dictionary_method(bm, "Minimum     #{big_o['Minimum']}", ds) { |d, size| d.min }
    benchmark_dictionary_method(bm, "Predecessor #{big_o['Predecessor']}", ds) { |d, size| d.predecessor(size/2) }
    benchmark_dictionary_method(bm, "Successor   #{big_o['Successor']}", ds) { |d, size| d.successor(size/2) }
  end
end

def benchmark_dictionary_method(bm, title, ds, &blk)
  puts "\n"
  puts title
  puts "\n"
  ds.each do |d, size|
    bm.report format_number(size) do
      blk.call(d, size)
    end
  end
end

def format_number(number)
  formatted_number = number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  formatted_number.rjust(20)
end

linked_list_sizes = [
  10,
  100,
  1_000,
  10_000,
  100_000,
  1_000_000,
  10_000_000,
]

linked_list_big_o = {
  "Insert"      => "O(1)",
  "Search"      => "O(n)",
  "Delete"      => "O(n)",
  "Maximum"     => "O(1)",
  "Minimum"     => "O(1)",
  "Predecessor" => "O(n)",
  "Successor"   => "O(n)",
}

binary_search_tree_sizes = [
  10,
  100,
  1_000,
  10_000,
  100_000,
  1_000_000,
  # 10_000_000, # takes ~7mins to load all the inserts
]

binary_search_tree_big_o = {
  "Insert"      => "O(h)",
  "Search"      => "O(n) =[",
  "Delete"      => "O(h)",
  "Maximum"     => "O(1)",
  "Minimum"     => "O(1)",
  "Predecessor" => "O(h)",
  "Successor"   => "O(h)",
}

# benchmark_dictionary(LinkedList::Dictionary, linked_list_sizes, linked_list_big_o)
benchmark_dictionary(BinarySearchTree::Dictionary, binary_search_tree_sizes, binary_search_tree_big_o)

# Benchmark.bm 30 do |bm|
#   d = BinarySearchTree::Dictionary.new

#   binary_search_tree_sizes.each do |size|
#     count = 0
#     bm.report format_number(size).to_s.rjust(20) do
#       (1..size).to_a.shuffle.each do |i|
#         # bm.report count.to_s.rjust(20) do
#           d.insert i
#           count += 1
#         # end
#       end
#     end
#   end
# end
