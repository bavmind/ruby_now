# frozen_string_literal: true

require "test_helper"
require "minitest/autorun"
require "mocha/minitest"
require "json"
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

    assert_equal 200, response.status, "Response should be 200"
    assert result.key?("result"), "Response should include 'result'"
    assert result["result"].is_a?(Array), "Response should include 'result' as an array"
    assert_predicate result["result"].length, :positive?, "Response should include at least one result"
  end

  def test_real_post_request
    # Create a new knowledge base
    generated_title = "_Test Knowledge Base #{Time.now.to_i}"
    body = {
      title: generated_title
    }
    response = @client.post("/api/now/table/kb_knowledge_base", body)
    result = JSON.parse(response.body)

    assert_equal 201, response.status, "Response should be 201"
    assert result.key?("result"), "Response should include 'result'"
    assert result["result"].key?("sys_id"), "Response should include 'sys_id'"
    assert_equal generated_title, result["result"]["title"], "Response should include the title we sent"
  end
end
