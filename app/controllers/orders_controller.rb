require 'tempfile'

class OrdersController < ApplicationController

  def edit

  end

  def create
    flash['notice'] = CsvUploaderAction.new(orders:          ParseOrderCsv.new(csv_file: params[:csv]).call,
                                            data_normalizer: NormalizeData).call.notice
  end

end
