module Abacus::InsertionSort
  extend self

  def sort(data)
    return [] if data.nil?

    for i in 1...data.length
      j = i
      while j > 0 && (data[j] < data[j-1]) do
        Abacus.swap(data, j, j-1)
        j = j-1
      end
    end

    data
  end
end
