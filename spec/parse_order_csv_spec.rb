require 'spec_helper'
require 'csv'
require_relative '../app/models/parse_order_csv'
require 'parse_order_stub'

RSpec.describe ParseOrderCsv do

  let(:csv_file) { File.open(File.join(File.dirname(__FILE__), 'example_data.csv')) }

  it 'takes a file object' do
    described_class.new(csv_file: csv_file)
  end

  describe '#call' do

    it 'returns a array of hashes' do
      described_class.new(csv_file: csv_file).call.to_ary
      described_class.new(csv_file: csv_file).call.to_ary.first.to_h
    end

    it 'rows is converted to hash' do
      expect(described_class.new(csv_file: csv_file).call).to eq ParseOrderStub.new(csv_file: nil).call
    end

    it 'has correct count' do
      expect(described_class.new(csv_file: csv_file).call.count).to eq 4
    end

  end

end