# frozen_string_literal: true

require_relative "ruby_now/version"
require_relative "ruby_now/client"

module RubyNow
  class Error < StandardError; end
  class TimeoutError < Error; end
  class AuthenticationError < Error; end
  class BadRequestError < Error; end
  class NotFoundError < Error; end
  class ServerError < Error; end
end
