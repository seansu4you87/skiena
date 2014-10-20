module Abacus::MergeSort
  extend self

  def sort(data)
    return [] if data.nil? || data.empty?
    return data if data.length == 1

    a, b = split(data)
    sorted_a = sort(a)
    sorted_b = sort(b)
    merge(sorted_a, sorted_b)
  end

  def merge(a, b)
    result = []

    current = a
    other = b

    swap = lambda do
      tmp = current
      current = other
      other = tmp
    end

    until a.empty? && b.empty? do
      if current.empty?
        swap.call
      else
        if other.empty? || current.first <= other.first
          result << current.shift
        else
          swap.call
        end
      end
    end

    result
  end

  def split(data)
    return if data.empty? || data.length == 1

    middle = (data.length / 2.0).ceil
    a = data[0...middle]
    b = data[middle..-1]
    [a, b]
  end
end
