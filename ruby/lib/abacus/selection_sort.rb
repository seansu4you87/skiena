module Abacus::SelectionSort
  extend self

  def sort(data)
    return [] if data.nil?

    for i in 0...data.length
      min = Float::INFINITY
      min_index = -1
      for j in i...data.length
        if data[j] < min
          min_index = j
          min = data[min_index]
        end
      end

      Abacus.swap(data, i, min_index)
    end

    data
  end
end
