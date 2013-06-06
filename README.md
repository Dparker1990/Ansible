# Ansible

Ansible provides a conveniant way to declaratively stream Server-Sent Events to the client using Rails 4.

## Installation

Add this line to your application's Gemfile:

    gem 'ansible'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ansible

## Usage

To use Ansible, simply add this to your controller for any model you want to transmit events for:

```ruby
transmit :model
```

## Requirements

    * Postgres (Ansible makes use of LISTEN / NOTIFY )

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
