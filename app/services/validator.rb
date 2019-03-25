class Validator
  attr_accessor :data, :errors

  ACTIONS = %w[accepts recommends].freeze

  def initialize(data)
    @data = data
    @errors = []
  end

  def self.call(data)
    new(data).validate
  end

  def validate
    validate_rows

    self
  end

  private

  def validate_rows
    data.split("\n").each.with_index do |row, index|
      row.strip!
      validate_actions(row, index)
      validate_row(row, index)
      validate_date(row, index)
    end
  end

  def validate_date(row, index)
    data = row.split(' ')[0]
    Time.zone.parse(data)
  rescue ArgumentError
    @errors << Errors::DateError.new("Date invalid at index #{index}")
  end

  def validate_actions(row, index)
    return if ACTIONS.select do |keyword|
      row.downcase.include?(keyword)
    end.any?

    @errors << Errors::ActionError.new("Action in invalid at index #{index}")
  end

  def validate_row(row, index)
    splitted_count = row.split(' ').count
    if row.include?('recommends') && splitted_count < 5
      message = "Row data in invalid for recommends actions at index #{index}"
      @errors << Errors::RowError.new(message)
    elsif splitted_count < 4
      message = "Row data in invalid for accepts actions at index #{index}"
      @errors << Errors::RowError.new(message)
    end
  end
end
