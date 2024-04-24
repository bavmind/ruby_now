# frozen_string_literal: true

require "faraday"
require "json"
require "base64"

module RubyNow
  # Client is a wrapper around Faraday to interact with the ServiceNow API
  class Client
    attr_reader :host, :user, :password

    def initialize(host, user, password, options = {})
      @host = host
      @user = user
      @password = password
      @timeout = options[:timeout] || 10
      setup_connection
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

    def setup_connection
      @connection = Faraday.new(url: "https://#{@host}") do |faraday|
        setup_faraday(faraday)
      end
    end

    def setup_faraday(faraday)
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      setup_headers(faraday)
      setup_options(faraday)
    end

    def setup_headers(faraday)
      faraday.headers["Content-Type"] = "application/json; charset=utf-8"
      faraday.headers["Accept"] = "application/json"
      faraday.headers["Authorization"] = "Basic #{Base64.strict_encode64("#{@user}:#{@password}")}"
    end

    def setup_options(faraday)
      faraday.options.timeout = @timeout
      faraday.options.open_timeout = @timeout
    end
  end
end
