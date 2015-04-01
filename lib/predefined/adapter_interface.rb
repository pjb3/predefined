module Predefined
  module AdapterInterface
    def to_sql(params=nil)
      raise "Not Implemented"
    end

    def select_all(params=nil)
      raise "Not Implemented"
    end

    def select_one(params=nil)
      raise "Not Implemented"
    end

    def select_rows(params=nil)
      raise "Not Implemented"
    end

    def select_values(params=nil)
      raise "Not Implemented"
    end

    def select_value(params=nil)
      raise "Not Implemented"
    end

    def select_object(klass, params=nil)
      raise "Not Implemented"
    end

    def select_objects(klass, parmas=nil)
      raise "Not Implemented"
    end
  end
end
