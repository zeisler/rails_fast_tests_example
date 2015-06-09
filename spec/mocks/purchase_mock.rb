require 'active_mocker/mock'

class PurchaseMock < ActiveMocker::Mock::Base
  created_with('1.8.3')

  class << self

    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "count"=>nil, "person_id"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::Mock::HashProcess.new({ id: Fixnum, count: Fixnum, person_id: Fixnum }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {}.merge(super)
    end

    def mocked_class
      "Purchase"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "count", "person_id"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "purchases" || super
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

  def count
    read_attribute(:count)
  end

  def count=(val)
    write_attribute(:count, val)
  end

  def person_id
    read_attribute(:person_id)
  end

  def person_id=(val)
    write_attribute(:person_id, val)
  end

  ##################################
  #         Associations           #
  ##################################



  module Scopes
    include ActiveMocker::Mock::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Mock::Association
    include PurchaseMock::Scopes
  end

  private

  def self.new_relation(collection)
    PurchaseMock::ScopeRelation.new(collection)
  end

  public

  ##################################
  #        Model Methods           #
  ##################################


end