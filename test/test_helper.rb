require 'minitest/autorun'
require 'predefined/query'

Predefined::Query.template_paths << File.expand_path('queries', File.dirname(__FILE__))
