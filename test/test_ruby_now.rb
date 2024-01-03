# frozen_string_literal: true

require "test_helper"
require "minitest/autorun"
require "mocha/minitest"
require "json"
require "rest-client"
require "dotenv/load"

class TestRubyNow < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RubyNow::VERSION
  end

  def setup
    service_now_instance = ENV.fetch("SERVICE_NOW_INSTANCE")
    username = ENV.fetch("SERVICE_NOW_USERNAME")
    passowrd = ENV.fetch("SERVICE_NOW_PASSWORD")
    @client = RubyNow::Client.new("#{service_now_instance}.service-now.com", username, passowrd)
  end

  def test_real_get_request
    response = @client.get("/api/now/table/kb_knowledge_base")
    result = JSON.parse(response.body)

    assert_equal 200, response.code, "Response should be 200"
    assert result.key?("result"), "Response should include 'result'"
    assert result["result"].is_a?(Array), "Response should include 'result' as an array"
    assert_predicate(result["result"].length, :positive?, "Response should include at least one result")
  end
end
