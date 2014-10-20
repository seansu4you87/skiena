module Abacus::HeapSort
  extend self

  def sort(data)
    return [] if data.nil?

    heap = Lego::Heap.new
    data.each { |datum| heap << datum }

    result = []
    while heap.size > 0 do
      result << heap.extract
    end
    result
  end
end
