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

  def test_get_request
    @test_endpoint = "api/test_endpoint"
    @test_body = { key: "value" }

    mock_response = { "result" => "success" }.to_json
    RestClient::Request.expects(:execute).returns(mock_response)
    response = @client.get(@test_endpoint)

    assert_equal "success", response["result"]
  end

  def test_real_get_request
    response = @client.get("/api/now/table/kb_knowledge_base")

    assert response.key?("result"), "Response should include 'result'"
  end
end
