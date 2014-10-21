require_relative 'benchmark'

# Analysis.heap.run scale(2, tens) # (10_000_000, 27 sec), (100_000_000, 4.5 min/270 sec)
# Analysis.heap(heapify: true).run scale(2, tens)
# Analysis.priority_queue.run tens

# Heapify vs Naive analysis
Analysis.new(Lego::Heap, "heapify sorted"){ |heap, size| heap.send(:heapify, (1...size).to_a) }.run twos
Analysis.new(Lego::Heap, "heapify random"){ |heap, size| heap.send(:heapify, (1...size).to_a.shuffle) }.run twos
Analysis.new(Lego::Heap, "heapify reverse"){ |heap, size| heap.send(:heapify, (1...size).to_a.reverse) }.run twos
Analysis.new(Lego::Heap, "naive sorted"){ |heap, size| (1...size).to_a.each { |i| heap.insert i } }.run twos
Analysis.new(Lego::Heap, "naive random"){ |heap, size| (1...size).to_a.shuffle.each { |i| heap.insert i } }.run twos
Analysis.new(Lego::Heap, "naive reverse"){ |heap, size| (1...size).to_a.reverse.each { |i| heap.insert i } }.run twos

