require_relative 'priority_queue'

describe PriorityQueue do
  let(:pq) { PriorityQueue.new }

  describe "#push" do
    it "pushes" do
      pq.push 4, "Sean"
      pq.push 5, "Yu"
      pq.push 2, "Hello"

      expect(pq.to_s).to eql '(2, Hello), (5, Yu), (4, Sean)'
    end
  end

  describe "#pop" do
    it "pops the lowest priority value" do
      pq.push 4, "Sean"
      pq.push 5, "Yu"
      pq.push 2, "Hello"

      expect(pq.pop).to eql "Hello"
      expect(pq.pop).to eql "Sean"
      expect(pq.pop).to eql "Yu"
    end
  end

  describe "#peek" do
    it "peeks at the lowest priority value" do
      pq.push 4, "Sean"
      pq.push 5, "Yu"
      pq.push 2, "Hello"

      expect(pq.peek).to eql "Hello"
      # Should still be Hello
      expect(pq.peek).to eql "Hello"
    end
  end
end
