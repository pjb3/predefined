require 'predefined/query'

module Predefined
  class SequelQuery < Query
    def db
      @options[:db]
    end

    def dataset(params=nil)
      db.fetch(template, params || {})
    end

    def to_sql(params=nil)
      dataset(params).sql
    end

    def select_all(params=nil)
      dataset(params).all
    end

    def select_one(params=nil)
      dataset(params).first
    end

    def select_rows(params=nil)
      raise "TODO: Implement Me"
    end

    def select_values(params=nil)
      raise "TODO: Implement Me"
    end

    def select_value(params=nil)
      dataset(params).get
    end

    def select_object(klass, params=nil)
      raise "TODO: Implement Me"
    end

    def select_objects(klass, parmas=nil)
      raise "TODO: Implement Me"
    end
  end

  module SequelHelpers
    include Helpers
    def predefined_helper_query_class
      SequelQuery
    end
  end
end
