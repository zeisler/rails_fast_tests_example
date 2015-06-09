require 'active_mocker/mock'

class PersonMock < ActiveMocker::Mock::Base
  created_with('1.8.3')

  class << self

    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "first_name"=>nil, "last_name"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::Mock::HashProcess.new({ id: Fixnum, first_name: String, last_name: String }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {}.merge(super)
    end

    def mocked_class
      "Person"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "first_name", "last_name"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "people" || super
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

  def first_name
    read_attribute(:first_name)
  end

  def first_name=(val)
    write_attribute(:first_name, val)
  end

  def last_name
    read_attribute(:last_name)
  end

  def last_name=(val)
    write_attribute(:last_name, val)
  end

  ##################################
  #         Associations           #
  ##################################



  module Scopes
    include ActiveMocker::Mock::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Mock::Association
    include PersonMock::Scopes
  end

  private

  def self.new_relation(collection)
    PersonMock::ScopeRelation.new(collection)
  end

  public

  ##################################
  #        Model Methods           #
  ##################################


end