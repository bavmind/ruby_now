# RubyNowClient

RubyNowClient is a Ruby wrapper for interacting with the ServiceNow API. It simplifies the process of making GET, POST, and PATCH requests to ServiceNow instances, handling authentication and response parsing seamlessly. This gem is designed to be easy to use for Ruby developers looking to integrate ServiceNow functionalities into their applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_now_client'
```

And then execute:

```sh
$ bundle install
```

Or install it yourself as:

```sh
$ gem install ruby_now_client
```

## Usage

To start using the RubyNowClient, you need to require it in your Ruby application and configure it with your ServiceNow instance details.

### Configuration

Initialize a client with your ServiceNow instance's host, user, and password:

```ruby
require 'ruby_now_client'

client = RubyNowClient::API.new('your-instance.service-now.com', 'username', 'password')
```

### Making Requests

You can make GET, POST, and PATCH requests to your ServiceNow instance using the client.

#### GET Request

```ruby
response = client.get('api/endpoint')
```

#### POST Request

```ruby
response = client.post('api/endpoint', { key: 'value' })
```

#### PATCH Request

```ruby
response = client.patch('api/endpoint', { key: 'new_value' })
```

### Error Handling

Handle any potential errors during API calls:

```ruby
begin
  response = client.get('api/endpoint')
rescue RestClient::ExceptionWithResponse => e
  puts "An error occurred: #{e.message}"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bavmind/ruby_now_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/bavmind/ruby_now_client/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RubyNowClient project's codebases, issue trackers, chat rooms, and mailing lists is expected to follow the [code of conduct](https://github.com/bavmind/ruby_now_client/blob/main/CODE_OF_CONDUCT.md).
