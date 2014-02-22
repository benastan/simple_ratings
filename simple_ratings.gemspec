# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_ratings/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_ratings"
  spec.version       = SimpleRatings::VERSION
  spec.authors       = ["Ben Bergstein"]
  spec.email         = ["bennyjbergstein@gmail.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rerun"
  spec.add_development_dependency "fakefs"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency "foreman"
  
  spec.add_dependency 'pg'
  spec.add_dependency 'sequel'
  spec.add_dependency 'sinatra'
  spec.add_dependency 'faraday'
  spec.add_dependency 'sprockets'
  spec.add_dependency 'sass'
  spec.add_dependency 'sprockets-browserify'
  spec.add_dependency 'handlebars_assets'
end
