class CsvUploader

  def initialize(orders:, data_normalizer:)
    @orders          = orders.to_ary
    @data_normalizer = data_normalizer
  end

  def call
    self.processed_orders = orders.map do |order|
      data_normalizer.new(data: order).call
    end
    self
  end

  def gross_revenue
    processed_orders.map(&:gross_revenue).inject(:+)
  end

  private

  attr_reader :data_normalizer, :orders
  attr_accessor :processed_orders

end