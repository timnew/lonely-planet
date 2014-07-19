require './lib/all'

RSpec.configure do |config|
  config.mock_with :rr

  config.expect_with :rspec do |expectations|
    expectations.syntax = [:expect, :should]
  end
end
