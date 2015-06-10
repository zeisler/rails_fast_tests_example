class ParseOrderCsv

  attr_reader :csv_file

  def initialize(csv_file:)
    @csv_file = csv_file
  end

  def call
    array = []
    CSV.parse(csv_file.read, :headers => true) do |row|
      array << row.to_h
    end
    array
  end

end