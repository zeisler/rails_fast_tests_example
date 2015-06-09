require 'active_mocker/mock'

class ProductMock < ActiveMocker::Mock::Base
  created_with('1.8.3')

  class << self

    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "price"=>nil, "description"=>nil, "merchant_id"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::Mock::HashProcess.new({ id: Fixnum, price: BigDecimal, description: String, merchant_id: Fixnum }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {}.merge(super)
    end

    def mocked_class
      "Product"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "price", "description", "merchant_id"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "products" || super
    end

  end

  ##################################
  #   Attributes getter/setters    #
  ##################################

  def id
    read_attribute(:id)
  end

  def id=(val)
    write_attribute(:id, val)
  end

  def price
    read_attribute(:price)
  end

  def price=(val)
    write_attribute(:price, val)
  end

  def description
    read_attribute(:description)
  end

  def description=(val)
    write_attribute(:description, val)
  end

  def merchant_id
    read_attribute(:merchant_id)
  end

  def merchant_id=(val)
    write_attribute(:merchant_id, val)
  end

  ##################################
  #         Associations           #
  ##################################



  module Scopes
    include ActiveMocker::Mock::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Mock::Association
    include ProductMock::Scopes
  end

  private

  def self.new_relation(collection)
    ProductMock::ScopeRelation.new(collection)
  end

  public

  ##################################
  #        Model Methods           #
  ##################################


end