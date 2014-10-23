module Abacus::BubbleSort
  extend self

  def sort(data)
    return [] if data.nil?

    data = data.dup
    swapped = true
    while swapped do
      swapped = bubble_pass!(data)
    end
    data
  end

  def bubble_pass!(data)
    swapped = false
    (0..data.length).each do |i|
      cur = data[i]
      nex = data[i+1]
      return swapped if nex.nil?

      if cur > nex
        Abacus.swap(data, i, i+1)
        swapped = true
      end
    end

    return swapped
  end
end
