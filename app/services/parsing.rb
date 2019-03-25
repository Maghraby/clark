class Parsing
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def self.call(data)
    new(data).parse
  end

  def parse
    data.split("\n").map do |row|
      format(row)
    end
  end

  private

  def format(row)
    OpenStruct.new(
      from: from(row),
      to: to(row),
      accepts?: accepts?(row),
      recommends?: recommends?(row)
    )
  end

  def from(row)
    row.split(' ')[2]
  end

  def to(row)
    return unless recommends?(row)

    row.split(' ')[4]
  end

  def action(row)
    row.include?('accepts') ? 'accepts' : 'recommends'
  end

  %w[accepts recommends].each do |action_type|
    define_method "#{action_type}?" do |row|
      action(row) == action_type
    end
  end
end
