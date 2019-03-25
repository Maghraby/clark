class Calculator
  POINT_COUNT = 3
  POINT_BASE_POWER = 0.5

  delegate :errors, to: :validator

  attr_accessor :rows, :nodes, :response, :validator

  def initialize(data)
    @validator = Validator.call(data)
    @rows = Parsing.call(data)
    @nodes = {}
    @response = []
  end

  def self.call(data)
    new(data).calculate
  end

  def calculate
    return self unless success?

    build_rows
    update_response

    self
  end

  def success?
    errors.empty?
  end

  private

  def build_rows
    rows.each do |row|
      if row.recommends?
        add_new_award(row.from, row.to)
      else
        update_pointing(row.from)
      end
    end
  end

  def update_response
    @response = nodes.reject { |_, node| node.points.zero? }.map do |key, node|
      {
        key.to_s => node.points
      }
    end
  end

  def add_new_award(parent, child)
    parent_node = search(parent)
    parent_node ||= insert_new_node(nil, parent)

    child_node = search(child)
    insert_new_node(parent_node, child) unless child_node
  end

  def update_pointing(child)
    node = search(child)

    update_parents_point(node, 0)

    node
  end

  def update_parents_point(node, level)
    return if level == POINT_COUNT

    parent = node.parent

    return unless parent

    parent.points += POINT_BASE_POWER**level

    update_parents_point(parent, level.next)
  end

  def search(node)
    nodes[node]
  end

  def insert_new_node(parent, value)
    node = Node.call(value, parent)
    nodes[value] = node

    node
  end
end
