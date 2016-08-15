$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ezapi_client'
require "yaml"
require "pry"
require "pry-byebug"
require "virtus-matchers"
require "vcr"
require "webmock"

SPEC_DIR = Pathname.new(File.dirname(__FILE__))
CONFIG = YAML.load_file(SPEC_DIR.join("config.yml")).with_indifferent_access

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
