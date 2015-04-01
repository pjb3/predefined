require 'predefined/active_record'

module Predefined
  class Railtie < Rails::Railtie
    initializer "predefined.configure_template_paths" do
      Predefined::Query.template_paths = Rails.root.join('app/queries')
    end
  end
end
