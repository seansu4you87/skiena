require 'benchmark'

require_relative 'analysis'
require_relative '../lib/abacus'
require_relative '../lib/lego'

# BENCHMARK!!!

# Analysis.dictionary_ll.run [
#   10,
#   100,
#   1_000,
#   10_000,
#   100_000,
#   # 1_000_000,
#   # 10_000_000,
# ]

# Analysis.dictionary_bst.run [
#   10,
#   100,
#   1_000,
#   10_000,
#   100_000,
#   # 1_000_000, # takes 8 seconds
#   # 10_000_000, # takes like 7 fucking minutes!
# ]

# Analysis.heap.run [
#   10,
#   100,
#   1_000,
#   10_000,
#   100_000,
#   # 1_000_000,
#   # 10_000_000, # 27 seconds
#   # 100_000_000, # 4.5 minutes (270 seconds)
# ]

# Analysis.priority_queue.run [
#   10,
#   100,
#   1_000,
#   10_000,
#   # 100_000,
#   # 1_000_000,
#   # 10_000_000,
# ]

sizes = [
  10,
  100,
  1_000,
  10_000,
  # 100_000,
  # 1_000_000,
  # 10_000_000,
  # 100_000_000,
]

# TODO(yu): compare specific methods on different Analysis objects
# method_name = "Insert"
# ll.run(sizes, method_name)
# bst.run(sizes, method_name)

Analysis.heap_sort.run sizes, silence_creation: true
Analysis.merge_sort.run sizes, silence_creation: true
Analysis.quicksort.run sizes, silence_creation: true
Analysis.ruby_sort.run sizes, silence_creation: true
