# Ready::For::Migration

This is an Rails Engine that provides an endpoint that responds whether the application migration has done or not.

## Usage

Add this line to your Rails application's config/routes.rb:

```
mount Ready::For::Migration::Engine, at: '/healthz'

```

This makes the path "/healthz" available.
If your application migration has be done, it returns 200 OK, otherwise it returns 503 Service Unavailable.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ready-for-migration'
```

Or install it yourself as:

```bash
$ gem install ready-for-migration
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
