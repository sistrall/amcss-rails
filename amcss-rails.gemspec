# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'amcss/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "amcss-rails"
  spec.version       = Amcss::Rails::VERSION
  spec.authors       = ["Silvano Stralla"]
  spec.email         = ["silvano.stralla@sistrall.it"]
  spec.summary       = %q{AMCSS for Rails}
  spec.description   = %q{Define a series of helpers to make it easy to use AMCSS in Rails project}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'amcss'
  spec.add_dependency 'rails'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'combustion'
end
