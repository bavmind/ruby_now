# frozen_string_literal: true

require "faraday"
require "json"

module RubyNow
  # Client is a wrapper around Faraday to interact with the ServiceNow API
  class Client
    attr_reader :host, :user, :password

    def initialize(host, user, password)
      @host = host
      @user = user
      @password = password
      @connection = Faraday.new(url: "https://#{host}") do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
        faraday.headers["Content-Type"] = "application/json"
        faraday.headers["Accept"] = "application/json"
        faraday.headers["Authorization"] = "Basic #{Base64.strict_encode64("#{user}:#{password}")}"
      end
    end

    def get(endpoint, body = nil)
      interact(:get, endpoint, body)
    end

    def post(endpoint, body)
      interact(:post, endpoint, body)
    end

    def patch(endpoint, body)
      interact(:patch, endpoint, body)
    end

    def delete(endpoint, body = nil)
      interact(:delete, endpoint, body)
    end

    private

    def interact(method, endpoint, body)
      @connection.send(method) do |req|
        req.url endpoint
        req.body = body.to_json if body
      end
    rescue Faraday::Error => e
      puts "ERROR: #{e.message}"
      raise
    end
  end
end
