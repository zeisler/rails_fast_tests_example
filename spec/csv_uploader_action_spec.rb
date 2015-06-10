require 'spec_helper'
require_relative '../app/models/csv_uploader_action'
require_relative '../app/models/normalize_data'
require_relative '../app/models/parse_order_csv'
require 'parse_order_stub'
require 'normalize_data_stub'

RSpec.describe CsvUploaderAction do

  it 'take an order of hashes' do
    CsvUploaderAction.new(orders: ParseOrderStub.new(csv_file: nil).call, data_normalizer: NormalizeDataStub)
  end

  describe '#call' do

    it 'calls data_normalizer for each row' do
      expect(NormalizeDataStub).to receive(:new).and_call_original.exactly(4).times
      CsvUploaderAction.new(orders: ParseOrderStub.new(csv_file: nil).call, data_normalizer: NormalizeDataStub).call
      expect(NormalizeDataStub._call_called_count).to eq 4
    end

    it 'get the gross revenue' do
      allow_any_instance_of(NormalizeDataStub).to receive(:gross_revenue){10}
      result = CsvUploaderAction.new(orders: ParseOrderStub.new(csv_file: nil).call, data_normalizer: NormalizeDataStub).call
      expect(result.gross_revenue).to eq 40.0
    end

    it '#notice' do
      allow_any_instance_of(NormalizeDataStub).to receive(:gross_revenue) { 10 }
      result = CsvUploaderAction.new(orders: ParseOrderStub.new(csv_file: nil).call, data_normalizer: NormalizeDataStub).call
      expect(result.notice).to eq "Successfully uploaded csv with gross revenue of $40"
    end

  end

end