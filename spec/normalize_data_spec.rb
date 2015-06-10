require 'spec_helper'
require 'active_mocker/rspec_helper'
require_relative '../app/models/normalize_data'
require 'mocks/merchant_mock'
require 'mocks/person_mock'
require 'mocks/purchase_mock'
require 'mocks/product_mock'

RSpec.describe NormalizeData, active_mocker: true do

  before do
    ActiveMocker::LoadedMocks.delete_all
  end

  let(:denormal_data) {
    { "purchaser name"   => "Snake Plissken",
      "item description" => "$10 off $20 of food",
      "item price"       => 10.0,
      "purchase count"   => 2,
      "merchant address" => "987 Fake St",
      "merchant name"    => "Bob's Pizza" }
  }

  context 'will normalize data into correct models' do

    subject! { NormalizeData.new(data: denormal_data).call }

    it 'person' do
      expect(Person.first.attributes.except("id")).to eq({ "first_name" => "Snake", "last_name" => "Plissken" })
    end

    it 'product' do
      expect(Product.first.description).to eq("$10 off $20 of food")
      expect(Product.first.price.to_f).to eq(10.0)
      expect(Product.first.merchant_id).to eq(Merchant.first.id)
    end

    it 'merchant' do
      expect(Merchant.first.address).to eq("987 Fake St")
      expect(Merchant.first.name).to eq("Bob's Pizza")
    end

    it 'purchase' do
      expect(Purchase.first.product_id).to eq(Product.first.id)
      expect(Purchase.first.person_id).to eq(Person.first.id)
      expect(Purchase.first.count).to eq(2)
    end

    it '#gross_revenue' do
      expect(subject.gross_revenue.to_f).to eq 20.0
    end

  end

  context 'reference data will only be created once' do
    let(:denormal_data1) {
      { "purchaser name"   => "Snake Plissken",
        "item description" => "$10 off $20 of food",
        "item price"       => 10.0,
        "purchase count"   => 1,
        "merchant address" => "987 Fake St",
        "merchant name"    => "Bob's Pizza" }
    }
    let(:denormal_data2) {
      { "purchaser name"   => "Snake Plissken",
        "item description" => "$10 off $20 of food",
        "item price"       => 10.0,
        "purchase count"   => 2,
        "merchant address" => "987 Fake St",
        "merchant name"    => "Bob's Pizza" }
    }

    before do
      NormalizeData.new(data: denormal_data1).call
      NormalizeData.new(data: denormal_data2).call
    end

    it 'purchase is created for every time' do
      expect(Purchase.count).to eq 2
      expect(Purchase.all.map(&:count)).to eq [1,2]
    end

    it 'merchant' do
      expect(Merchant.count).to eq 1
    end

    it 'person' do
      expect(Person.count).to eq 1
    end

    it 'product' do
      expect(Product.count).to eq 1
    end

  end

end