ENV["RAILS_ENV"] ||= "test"
require "uri"

# Compose の DATABASE_URL が development を指していても、テストは test DB を使う
if ENV["DATABASE_URL"].present?
  uri = URI.parse(ENV["DATABASE_URL"])
  uri.path = "/app_test"
  ENV["DATABASE_URL"] = uri.to_s
end

require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

module ActionDispatch
  class IntegrationTest
    include Devise::Test::IntegrationHelpers
  end
end
