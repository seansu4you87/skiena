class Heap
  class << self
    def heapify(array)
    end

    def merge(a, b)
    end

    def meld(a, b)
    end
  end
  def initialize
    @data = []
    @size = 0
  end

  def peek
    @data[1]
  end

  def extract
    dom = @data[1]
    @data[1] = @data[@size]
    @data[@size] = nil
    @data.pop if @data.last.nil?
    @size -= 1

    bubble_down(1)
    dom
  end

  def insert(key)
    # append to the end of the array, bubble up
    @data[@size + 1] = key
    @size += 1
    bubble_up(@size)
  end

  def size
    @size
  end

  def empty?
    @size == 0
  end

  def to_s
    _, *tail = @data
    tail.join(', ')
  end

  private

  def dominates?(a, b)
    a < b # min heap domination
  end

  def dominant(a, b)
    return [nil, :none] if a.nil? && b.nil?
    return [a, :left] if b.nil?
    return [b, :right] if a.nil?

    if dominates?(a, b)
      [a, :left]
    else
      [b, :right]
    end
  end

  def bubble_up(index)
    return if parent(index) == -1

    if dominates?(@data[index], @data[parent(index)])
      tmp = @data[parent(index)]
      @data[parent(index)] = @data[index]
      @data[index] = tmp
      bubble_up(parent(index))
    end
  end

  def bubble_down(index)
    return if index >= @size

    left = @data[left_child(index)]
    right = @data[right_child(index)]
    dom, side = dominant(left, right)

    return if dom.nil? && side == :none

    if dominates?(dom, @data[index])
      tmp = @data[index]
      @data[index] = dom
      if side == :left
        @data[left_child(index)] = tmp
        bubble_down(left_child(index))
      else
        @data[right_child(index)] = tmp
        bubble_down(right_child(index))
      end
    end
  end

  def parent(n)
    return -1 if n == 1
    (n / 2).floor
  end

  def left_child(n)
    2 * n
  end

  def right_child(n)
    left_child(n) + 1
  end
end
