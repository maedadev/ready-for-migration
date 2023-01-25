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

## Simulate Health Check Response

You can simulate health check response by adding specific query parameters to your health check requests.

Here's the pattern we're providing. (values are just an example)

|pattern|behavior|
|--|--|
|No query parameters|health check as usual.|
|`?status=503`|respond with specified status code.|
|`?status=503&after=60`|respond with specified status code once specified seconds have passed since the first access with `after`.|
|`?status=503&sleep=60`|respond with specified status code after sleeping specified seconds.|
|`?status=503&random=10` |randomly respond with specified status code, once in a specified number as `random`.|
|`?sleep=60` |health check after sleeping specified seconds.|

NOTE: Other patterns than listed in the above example will be ignored.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
