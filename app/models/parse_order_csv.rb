require 'csv'

class ParseOrderCsv

  attr_reader :csv_file

  def initialize(csv_file:)
    @csv_file = csv_file
  end

  def call
    array = []
    CSV.foreach(csv_file.path, :headers => true) do |row|
      array << row.to_h
    end
    array
  end

end