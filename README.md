# EZAPIClient

Ruby wrapper for EasyPadala's API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ezapi_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ezapi_client

## Usage

See `spec/functional` for examples.

## Development

1. Copy `spec/config.yml.sample` to `spec/config.yml` and fill up with your own details.
2. `docker-compose build`
3. `docker-compose run app rspec`

Note: you do not necessarily need Docker, but it makes development easier. If you want to work on this without it, then you need Java installed. See `Dockerfile` for clues.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/imacchiato/ezapi_client-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
