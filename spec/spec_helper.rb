ENV["RACK_ENV"] = "test"

require "rack/test"
require "rspec"
require "webmock/rspec"

require_relative "../lib/rebot"
require_relative "support/rebot_helpers"

Dir.glob("spec/support/*.rb").each { |fn| require_relative "../#{fn}" }

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include SlackApiHelpers
  config.include TogglApiHelpers
end
