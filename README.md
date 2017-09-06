# EZAPIClient

[![Build Status](https://travis-ci.org/imacchiato/ezapi_client-ruby.svg?branch=master)](https://travis-ci.org/imacchiato/ezapi_client-ruby)

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

1. Create `.env.local` and override the password (see `.env`). If you do not have access to the password but have your own credentials, then will have to override everything except `HOST`.
2. `docker-compose build`
2. `docker-compose run app bundle`
3. `docker-compose run app rspec`

Note: you do not necessarily need Docker, but it makes development easier. If you want to work on this without it, then you need Java installed. See `Dockerfile` for clues.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/imacchiato/ezapi_client-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
