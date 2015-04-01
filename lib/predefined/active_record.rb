require 'predefined/query'

module Predefined
  class ActiveRecordQuery < Query
    class Database < ActiveRecord::Base
      self.abstract_class = true
    end

    def connection
      Database.connection
    end

    def to_sql(params=nil)
      Database.send(:sanitize_sql, [template, params])
    end

    def select_all(params=nil)
      result_to_rows(connection.select_all(to_sql(params), name))
    end

    def select_one(params=nil)
      select_all(params).first
    end

    def select_rows(params=nil)
      connection.select_rows(to_sql(params), name)
    end

    def select_values(params=nil)
      connection.select_values(to_sql(params), name)
    end

    def select_value(params=nil)
      connection.select_value(to_sql(params), name)
    end

    def select_object(klass, params=nil)
      record = connection.select_one(to_sql(params), name)
      if record
        klass.new(record)
      end
    end

    def select_objects(klass, params=nil)
      connection.select_all(to_sql(params), name).map do |row|
        klass.new(row)
      end
    end

    # TODO: Is there a way to do this built-in to ActiveRecord?
    def result_to_rows(result)
      result.rows.map do |row|
        typed_row = result.columns.zip(row).map do |column_name, value|
          typed_value = result.column_types[column_name].send(:type_cast, value)
          [column_name.to_sym, typed_value]
        end
        Hash[typed_row]
      end
    end
  end

  module ActiveRecordHelpers
    include Helpers
    def predefined_helper_query_class
      ActiveRecordQuery
    end
  end
end
