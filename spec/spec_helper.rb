require 'simplecov'
SimpleCov.start

require './lib/all'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = [:expect, :should]
  end
end
