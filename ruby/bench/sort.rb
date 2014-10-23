require_relative 'benchmark'

# Sort analysis
# Heap sort and Merge sort are O(n logn) whereas Quicksort is O(n^2)
# However, because we randomize the quicksort, the average run is n logn,
# and ends up being considerably faster than both Heap sort and Merge sort
#
# The native ruby sort (quicksort implemented in c) is way faster though
# Quicksort on the worst case (already sorted) is terrible

TWOS = TWOS.first 15

# Analysis.ruby_sort.run TWOS, silence_creation: true
Analysis.quicksort.run TWOS, silence_creation: true
# Analysis.heap_sort.run TWOS, silence_creation: true
# Analysis.merge_sort.run TWOS, silence_creation: true
Analysis.bubble_sort.run TWOS, silence_creation: true

Analysis.quicksort(sorted: true).run TWOS, silence_creation: true
