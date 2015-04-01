# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'predefined/version'

Gem::Specification.new do |spec|
  spec.name          = "predefined"
  spec.version       = Predefined::VERSION
  spec.authors       = ["Paul Barry"]
  spec.email         = ["mail@paulbarry.com"]
  spec.summary       = %q{a library for writing parameterized SQL queries, executing them and mapping the result to on to objects.}
  spec.homepage      = "http://github.com/pjb3/predefined"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
