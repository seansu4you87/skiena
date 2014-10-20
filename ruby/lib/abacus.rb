module Abacus
  extend self

  def swap(array, i, j)
    tmp = array[i]
    array[i] = array[j]
    array[j] = tmp
  end
end

require_relative "abacus/insertion_sort"
require_relative "abacus/merge_sort"
require_relative "abacus/selection_sort"
