require 'spec_helper'
require_relative '../app/models/csv_uploader'
require_relative '../app/models/normalize_data'
require_relative '../app/models/parse_order_csv'
require 'parse_order_stub'
require 'normalize_data_stub'

RSpec.describe CsvUploader do

  it 'take an order of hashes' do
    CsvUploader.new(orders: ParseOrderStub.new(csv_file: nil).call, data_normalizer: NormalizeDataStub)
  end

  describe '#call' do

    it 'calls data_normalizer for each row' do
      expect(NormalizeDataStub).to receive(:new).and_call_original.exactly(4).times
      CsvUploader.new(orders: ParseOrderStub.new(csv_file: nil).call, data_normalizer: NormalizeDataStub).call
      expect(NormalizeDataStub._call_called_count).to eq 4
    end

    it 'get the gross revenue' do
      allow_any_instance_of(NormalizeDataStub).to receive(:gross_revenue){10}
      result = CsvUploader.new(orders: ParseOrderStub.new(csv_file: nil).call, data_normalizer: NormalizeDataStub).call
      expect(result.gross_revenue).to eq 40.0
    end

  end

end