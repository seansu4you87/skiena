class LinkedList
  class Error < StandardError; end
  class OutOfBoundsError < Error; end

  attr_accessor :value, :next

  def initialize(value, nex)
    self.value = value
    self.next = nex
  end

  def to_s
    if self.next.nil?
      tail = "nil"
    else
      tail = "#{self.next.to_s}"
    end
    "#{value.to_s} -> #{tail}"
  end

  class << self
    def index(head, i)
      node = head
      i.times do
        node = node.next
        raise LinkedList::OutOfBoundsError if node.nil?
      end
      node
    end

    def search(head, value)
      return head if head.value == value
      return nil if head.next.nil?

      search(head.next, value)
    end

    def delete(head, node)
      if head == node
        new_head = head.next
        head.next = nil
        new_head
      else
        prev = head
        curr = head.next

        while curr != nil do
          if curr == node
            prev.next = curr.next
            curr.next = nil
            return head
          end

          prev = curr
          curr = curr.next
        end

        return nil
      end
    end

    def delete_value(head, value)
      if head.value == value
        new_head = head.next
        head.next = nil
        new_head
      else
        prev = head
        curr = head.next

        while curr != nil do
          if curr.value == value
            prev.next = curr.next
            curr.next = nil
            return head
          end

          prev = curr
          curr = curr.next
        end

        return nil
      end
    end

    def reverse(head, before = nil)
      tail = head.next
      head.next = before

      if tail.nil?
        head
      else
        reverse(tail, head)
      end
    end
  end

  # Dictionary implemented with an unsorted LinkedList
  # Key will be the index into the LinkedList
  class Dictionary
    def initialize
      @_head = nil
      @_max = nil
      @_min = nil
    end

    # O(n)
    def search(k)
      LinkedList.index(@_head, k).value
    end

    # O(1)
    def insert(x)
      if @_head.nil?
        @_head = LinkedList.new(x, nil)
        @_max = @_head
        @_min = @_head
      else
        new_head = LinkedList.new(x, @_head)
        @_head = new_head

        if x > @_max.value
          @_max = @_head
        end

        if x < @_min.value
          @_min = @_head
        end
      end
    end

    # O(n)
    def delete(x)
      @_head = LinkedList.delete_value(@_head, x)

      @_max = @_head
      @_min = @_head
      curr = @_head
      while curr != nil
        if curr.value > @_max.value
          @_max = curr
        end

        if curr.value < @_min.value
          @_min = curr
        end
        curr = curr.next
      end
    end

    # O(1)
    def max
      @_max.value
    end

    # O(1)
    def min
      @_min.value
    end

    # O(n)
    def predecessor(x)
      curr = @_head
      node = @_head
      while curr != nil do
        if curr.value < x && ((x - curr.value) < (x - node.value) || node.value >= x)
          node = curr
        end
        curr = curr.next
      end

      if node.value >= x
        nil
      else
        node.value
      end
    end

    # O(n)
    def successor(x)
      curr = @_head
      node = @_head
      while curr != nil do
        if curr.value > x && ((curr.value - x) < (node.value - x) || node.value <= x)
          node = curr
        end
        curr = curr.next
      end

      if node.value <= x
        nil
      else
        node.value
      end
    end

    def to_s
      @_head.to_s
    end
  end
end
