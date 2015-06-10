class CsvUploaderAction

  def initialize(orders:, data_normalizer:)
    @orders          = orders.to_ary
    @data_normalizer = data_normalizer
  end

  def call
    @processed_orders = orders.map do |order|
      data_normalizer.new(data: order).call
    end
    self
  end

  def gross_revenue
    processed_orders.map(&:gross_revenue).inject(:+)
  end

  def notice
    "Successfully uploaded csv with gross revenue of $#{gross_revenue.round(0) }"
  end

  private

  attr_reader :data_normalizer, :orders
  attr_accessor :processed_orders

end