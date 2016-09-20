$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ezapi_client'
require "yaml"
require "pry"
require "pry-byebug"
require "virtus-matchers"
require "vcr"
require "webmock"
require "dotenv"

Dotenv.overload(".env", ".env.local")

config_vars = %i[username password agent_code host eks_path prv_path]
CONFIG = config_vars.each_with_object({}) do |var, hash|
  hash[var] = ENV[var.to_s.upcase]
end.with_indifferent_access

SPEC_DIR = Pathname.new(File.dirname(__FILE__))

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
