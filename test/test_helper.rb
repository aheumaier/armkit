if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'test'
    command_name 'Minitest'
  end
end

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

