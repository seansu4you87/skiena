class Analysis
  class << self
    def dictionary_ll
      ll = Analysis.new(Lego::LinkedList::Dictionary, "O(n)") do |d, size|
        (1...size).to_a.shuffle.each { |i| d.insert i }
      end

      ll << Analysis::Method.new("Insert", "O(1)") { |d, size| d.insert (size/2) }
      ll << Analysis::Method.new("Search", "O(n)") { |d, size| d.search (size/2) }
      ll << Analysis::Method.new("Delete", "O(n)") { |d, size| d.delete (size/2) }
      ll << Analysis::Method.new("Maximum", "O(1)") { |d, size| d.max }
      ll << Analysis::Method.new("Minimum", "O(1)") { |d, size| d.min }
      ll << Analysis::Method.new("Predecessor", "O(n)") { |d, size| d.predecessor (size/2) }
      ll << Analysis::Method.new("Successor", "O(n)") { |d, size| d.successor (size/2) }
      ll
    end

    def dictionary_bst
      bst = Analysis.new(Lego::BinarySearchTree::Dictionary, "O(n logn)") do |d, size|
        (1...size).to_a.shuffle.each { |i| d.insert i }
      end
      bst << Analysis::Method.new("Insert", "O(h)") { |d, size| d.insert (size/2) }
      bst << Analysis::Method.new("Search", "O(n) =[, could be better") { |d, size| d.search (size/2) }
      bst << Analysis::Method.new("Delete", "O(h)") { |d, size| d.delete (size/2) }
      bst << Analysis::Method.new("Maximum", "O(1)") { |d, size| d.max }
      bst << Analysis::Method.new("Minimum", "O(1)") { |d, size| d.min }
      bst << Analysis::Method.new("Predecessor", "O(h)") { |d, size| d.predecessor (size/2) }
      bst << Analysis::Method.new("Successor", "O(h)") { |d, size| d.successor (size/2) }
      bst
    end

    def heap(opts = {})
      if opts[:heapify]
        big_o = "O(n)"
      else
        big_o = "O(n log n) ?, seems to run in O(n)"
      end

      h = Analysis.new(Lego::Heap, big_o) do |heap, size|
        data = (1...size).to_a.shuffle

        if opts[:heapify]
          heap.send(:heapify, data)
        else
          data.each { |i| heap.insert i }
        end
      end

      h << Analysis::Method.new("Insert", "O(h)") { |d, size| d.insert (size/2) }
      h << Analysis::Method.new("Extract", "O(h)") { |d, size| d.extract }
      h
    end

    def priority_queue
      pq = Analysis.new(Lego::PriorityQueue, "O(n logn) ???") do |d, size|
        (1...size).to_a.shuffle.each { |i| d.push i }
      end
      pq << Analysis::Method.new("Push", "O(h)") { |d, size| d.push (size/2) }
      pq << Analysis::Method.new("Pop", "O(h)") { |d, size| d.pop }
      pq << Analysis::Method.new("Peek", "O(1)") { |d, size| d.peek }
      pq
    end

    def sort(&blk)
      blk ||= lambda do |array, size|
        (1...size).to_a.shuffle.each { |i| array << i }
      end

      Analysis.new(Array, "O(n) for array creation", &blk)
    end

    def heap_sort
      h = sort
      h << Analysis::Method.new("Heap Sort", "O(n logn)") { |array, _| Abacus::HeapSort.sort(array.dup) }
      h
    end

    def merge_sort
      m = sort
      m << Analysis::Method.new("Merge Sort", "O(n logn)") { |array, _| Abacus::MergeSort.sort(array.dup) }
      m
    end

    def quicksort(opts = {})
      if opts[:sorted]
        q = sort do |array, size|
          (1...size).to_a.each { |i| array << i }
        end
      else
        q = sort
      end

      q << Analysis::Method.new("Quicksort", "O(n logn) randomized)") { |array, _| Abacus::Quicksort.sort(array.dup) }
      q
    end

    def ruby_sort
      r = sort
      r << Analysis::Method.new("Ruby's Sort", "O(n logn)") { |array, _| array.dup.sort }
      r
    end
  end

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

  def run(sizes, opts = {})
    ds = {}
    sizes.each { |size| ds[size] = @klass.new }

    Benchmark.bm 30 do |bm|
      run_method(@creation_method, ds, bm, opts[:silence_creation])
      @methods.each { |method| run_method(method, ds, bm) }
    end
  end

  def run_method(method, ds, bm, silence = false)
    if silence
      ds.each { |size, d| method.blk.call(d, size) }
    else
      puts "\n#{method.name.ljust 15} #{method.big_o}\n\n"
      ds.each do |size, d|
        bm.report(format_size(size)) { method.blk.call(d, size) }
      end
    end
  end

  private

  def format_size(size)
    size.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.rjust(20)
  end
end

