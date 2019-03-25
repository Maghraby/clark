class Node
  attr_accessor :value, :parent, :points, :status

  def initialize(value, parent)
    @value  = value
    @parent = parent
    @points = 0
    @status = nil
  end

  def self.call(value, parent = nil)
    new(value, parent)
  end
end
