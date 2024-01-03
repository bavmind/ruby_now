# frozen_string_literal: true

require "base64"

# The RubyNow::Client class provides a Ruby interface to the ServiceNow API.
# It allows for sending GET, POST, and PATCH requests to specified endpoints
# with the necessary authentication and error handling.
module RubyNow
  class Client # rubocop:todo Style/Documentation
    attr_reader :host, :user, :password

    # Initializes a new client for ServiceNow.
    # @param host [String] the ServiceNow instance host URL.
    # @param user [String] the username for authentication.
    # @param password [String] the password for authentication.
    def initialize(host, user, password)
      @host = host
      @user = user
      @password = password
    end

    # Sends a PATCH request to the specified ServiceNow endpoint.
    # @param endpoint [String] the API endpoint to send the request to.
    # @param body [Hash] the request body, typically in Hash format.
    # @return [Hash] parsed JSON response from the ServiceNow API.
    # @raise [RestClient::ExceptionWithResponse] if the request fails.
    def patch(endpoint, body)
      interact(:patch, endpoint, body)
    end

    # Sends a POST request to the specified ServiceNow endpoint.
    # @param endpoint [String] the API endpoint to send the request to.
    # @param body [Hash] the request body, typically in Hash format.
    # @return [Hash] parsed JSON response from the ServiceNow API.
    # @raise [RestClient::ExceptionWithResponse] if the request fails.
    def post(endpoint, body)
      interact(:post, endpoint, body)
    end

    # Sends a GET request to the specified ServiceNow endpoint.
    # @param endpoint [String] the API endpoint to send the request to.
    # @param body [nil] the request body, nil for GET requests.
    # @return [Hash] parsed JSON response from the ServiceNow API.
    # @raise [RestClient::ExceptionWithResponse] if the request fails.
    def get(endpoint, body = nil)
      interact(:get, endpoint, body)
    end

    private

    # Handles the interaction with the ServiceNow API.
    # This method is used internally by public methods to send requests.
    # @param method [Symbol] the HTTP method (:get, :post, :patch).
    # @param endpoint [String] the API endpoint.
    # @param body [Hash, nil] the request body for POST and PATCH, nil for GET.
    # @return [Hash] parsed JSON response from the ServiceNow API.
    # @raise [RestClient::ExceptionWithResponse, StandardError] for any errors during the request.
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

    # Generates the necessary headers for ServiceNow API requests.
    # This method is used internally to set headers for each request.
    # @return [Hash] the headers required for the API request.
    def headers
      {
        content_type: "application/json",
        accept: "application/json",
        authorization: "Basic #{Base64.strict_encode64("#{user}:#{password}")}"
      }
    end
  end
end
