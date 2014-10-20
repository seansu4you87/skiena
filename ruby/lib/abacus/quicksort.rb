module Abacus::Quicksort
  extend self

  def sort(data)
    return [] if data.nil?
    return data if data.length == 0

    pivot = data.shift
    lte = [] # less than or equal
    mt = []  # more than

    data.each do |datum|
      if datum <= pivot
        lte << datum
      else
        mt << datum
      end
    end

    sort(lte) + [pivot] + sort(mt)
  end
end
