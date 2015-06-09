require 'active_mocker/mock'

class MerchantMock < ActiveMocker::Mock::Base
  created_with('1.8.3')

  class << self

    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "address"=>nil, "name"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::Mock::HashProcess.new({ id: Fixnum, address: String, name: String }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {}.merge(super)
    end

    def mocked_class
      "Merchant"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "address", "name"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "merchants" || super
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

  def address
    read_attribute(:address)
  end

  def address=(val)
    write_attribute(:address, val)
  end

  def name
    read_attribute(:name)
  end

  def name=(val)
    write_attribute(:name, val)
  end

  ##################################
  #         Associations           #
  ##################################



  module Scopes
    include ActiveMocker::Mock::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Mock::Association
    include MerchantMock::Scopes
  end

  private

  def self.new_relation(collection)
    MerchantMock::ScopeRelation.new(collection)
  end

  public

  ##################################
  #        Model Methods           #
  ##################################


end