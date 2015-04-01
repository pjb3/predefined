require 'predefined/adapter_interface'

module Predefined
  class Query
    include Predefined::AdapterInterface
    class Error < RuntimeError; end
    class MissingTemplateError < Error; end

    attr_reader :name

    def self.template_paths
      if defined? @template_paths
        @template_paths
      elsif superclass.respond_to?(:template_paths)
        superclass.template_paths
      else
        @template_paths ||= []
      end
    end

    def self.template_paths=(paths)
      @template_paths = Array(paths)
    end

    def self.template(name)
      @template ||= begin
        template_paths.each do |path|
          file = template_file(path, name)
          if File.exists?(file)
            return format_query(File.read(file))
          end
        end
        template_missing(name)
      end
    end

    def self.template_file(path, name)
      File.join(path, "#{name}.sql")
    end

    def self.template_missing(name)
      raise MissingTemplateError.new("Could not find template for query #{name.inspect} in #{template_paths.inspect}")
    end

    def self.format_query(sql)
      sql.to_s.split(/\n/).map(&:strip).join(' ')
    end

    def initialize(name)
      @name = name
    end

    def template
      self.class.template(name)
    end
  end

  module Helpers
    def predefined_helper_query_class
      raise "Not Implemented"
    end

    def select_all(template_name, params=nil)
      predefined_helper_query_class.new(template_name).select_all(params)
    end

    def select_one(template_name, params=nil)
      predefined_helper_query_class.new(template_name).select_one(params)
    end

    def select_rows(template_name, params=nil)
      predefined_helper_query_class.new(template_name).select_rows(params)
    end

    def select_values(template_name, params=nil)
      predefined_helper_query_class.new(template_name).select_values(params)
    end

    def select_value(template_name, params=nil)
      predefined_helper_query_class.new(template_name).select_value(params)
    end

    def select_object(template_name, klass, params=nil)
      predefined_helper_query_class.new(template_name).select_object(klass, params)
    end

    def select_objects(template_name, klass, params=nil)
      predefined_helper_query_class.new(template_name).select_objects(klass, params)
    end
  end
end
