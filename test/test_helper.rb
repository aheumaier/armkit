
if ENV['CC_TEST_REPORTER_ID']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'test'
    command_name 'Minitest'
  end
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "armkit"

require "minitest/autorun"

def valid_json?(json)
  JSON.parse(json)
  true
rescue
  false
end