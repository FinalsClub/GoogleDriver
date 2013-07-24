# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'yaml'
require 'rspec/core/shared_context'
require "google_driver"

RSpec.configure do |config|
  config.order = 'random'

  module FileFixtures
    extend RSpec::Core::SharedContext
    let (:file_doc) { File.expand_path("../files/April\ 13.doc", __FILE__) }
    let (:file_ppt) { File.expand_path("../files/Lecture_5.ppt", __FILE__) }
  end

  config.include FileFixtures

  ::PRIVATE = YAML::load_file(File.expand_path('../../private.yml', __FILE__))
end
