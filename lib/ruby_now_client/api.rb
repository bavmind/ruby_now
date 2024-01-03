# frozen_string_literal: true

require "rest-client"
require "json"
require "base64"

module RubyNowClient
  class API # rubocop:todo Style/Documentation
    attr_reader :host, :user, :password

    def initialize(host, user, password)
      @host = host
      @user = user
      @password = password
    end

    def patch(endpoint, body)
      interact(:patch, endpoint, body)
    end

    def post(endpoint, body)
      interact(:post, endpoint, body)
    end

    def get(endpoint, body = nil)
      interact(:get, endpoint, body)
    end

    private

    def interact(method, endpoint, body) # rubocop:todo Metrics/MethodLength
      url = "https://#{host}/#{endpoint}"
      puts "URL: #{url}"
      response = RestClient::Request.execute(
        method:,
        url:,
        payload: body.to_json,
        headers:,
        timeout: 15
      )

      # Add any response handling or parsing here if needed
      JSON.parse(response.to_str)
    rescue RestClient::ExceptionWithResponse => e
      # Handle specific RestClient exceptions if needed
      puts "ERROR: #{e.message}"
      puts "BODY: #{e.response.body}"
      raise
    rescue StandardError => e
      puts "ERROR: #{e.message}"
      raise
    end

    def headers
      {
        content_type: "application/json",
        accept: "application/json",
        authorization: "Basic #{Base64.strict_encode64("#{user}:#{password}")}"
      }
    end
  end
end
