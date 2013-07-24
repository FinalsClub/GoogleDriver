# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'goo_drive/version'

Gem::Specification.new do |spec|
  spec.name         = 'google_driver'
  spec.version       = GoogleDriver::VERSION
  spec.date          = '2013-07-22'
  spec.summary       = "A simple gem for processing documents to html with google drive"
  spec.description   = "A simple gem for processing documents to html with google drive"
  spec.authors       = ["Seth Wolfwood"]
  spec.email         = 'seth@sethish.com'
  spec.homepage      = 'https://github.com/FinalsClub/GoogleDriver'
  
  spec.files         = `git ls-files`.split($/)
  spec.test_files     = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.license       = "GPL"

  spec.add_dependency "google-api-client"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
end
