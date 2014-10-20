module InsertionSort
  extend self

  def sort(data)
    return [] if data.nil?

    for i in 1...data.length
      j = i
      while j > 0 && (data[j] < data[j-1]) do
        tmp = data[j]
        data[j] = data[j-1]
        data[j-1] = tmp
        # puts data.to_s
        j = j-1
      end
    end

    data
  end
end
