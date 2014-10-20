require 'benchmark'

require_relative 'analysis'
require_relative '../lib/abacus'
require_relative '../lib/lego'

# BENCHMARK!!!

sizes = [
  10,
  100,
  1_000,
  10_000,
  100_000,
  1_000_000,
  # 10_000_000,
  # 100_000_000,
]

# Analysis.dictionary_ll.run sizes
# Analysis.dictionary_bst.run sizes # (1_000_000, 8 sec), (10_000_000, 7 min)
# Analysis.heap.run sizes # (10_000_000, 27 sec), (100_000_000, 4.5 min/270 sec)
# Analysis.priority_queue.run sizes

# TODO(yu): compare specific methods on different Analysis objects
# method_name = "Insert"
# ll.run(sizes, method_name)
# bst.run(sizes, method_name)

Analysis.heap_sort.run sizes, silence_creation: true
Analysis.merge_sort.run sizes, silence_creation: true
Analysis.quicksort.run sizes, silence_creation: true
Analysis.ruby_sort.run sizes, silence_creation: true
