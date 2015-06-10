
#Code could of been sorter, but I wanted to show some OOP. I can think of cases where if the data had lots of error
#handling and parsing that it could be a nice way to handle changes and isolate complexity.
class NormalizeData

  def initialize(data:)
    @data = data.to_hash
  end

  def call
    person
    merchant
    product
    purchase
    self
  end

  def person
    @person ||= Person.find_or_create_by(PersonAttr.new(data).to_h)
  end

  def merchant
    @merchant ||= Merchant.find_or_create_by(MerchantAttr.new(data).to_h)
  end

  def product
    @product ||= Product.find_or_create_by(ProductAttr.new(data, merchant_id: merchant.id).to_h)
  end

  def purchase
    @purchase ||= Purchase.create(PurchaseAttr.new(data, person_id: person.id, product_id: product.id).to_h)
  end

  def gross_revenue
    purchase.count * product.price
  end

  private

  class Attr

    def initialize(data, **args)
      @data         = data
      @foreign_keys = foreign_keys
      post_initialize(args)
    end

    def to_h
      raise 'Unimplemented #to_h'
    end

    private

    def post_initialize(*)
    end

    attr_reader :data, :foreign_keys

  end

  class PersonAttr < Attr

    def to_h
      { first_name: first_name, last_name: last_name }
    end

    private

    def first_name
      data.fetch("purchaser name").split(' ').first
    end

    def last_name
      data.fetch("purchaser name").split(' ').last
    end

  end

  class MerchantAttr < Attr

    def to_h
      { address: address, name: name }
    end

    private

    def name
      data.fetch("merchant name")
    end

    def address
      data.fetch("merchant address")
    end

  end

  class ProductAttr < Attr

    def to_h
      { description: description, price: price, merchant_id: merchant_id }
    end

    private

    def post_initialize(merchant_id:)
      @merchant_id = merchant_id
    end

    attr_reader :merchant_id

    def description
      data.fetch("item description")
    end

    def price
      data.fetch("item price")
    end

  end

  class PurchaseAttr < Attr

    def to_h
      { count: count, person_id: person_id, product_id: product_id }
    end

    private

    def post_initialize(person_id:, product_id:)
      @person_id  = person_id
      @product_id = product_id
    end

    attr_reader :person_id, :product_id

    def count
      data.fetch("purchase count")
    end

  end

  attr_reader :data

end