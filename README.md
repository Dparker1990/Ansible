# Transmitter

Transmitter provides a conveviance method to wrap the ActionController::Live functionality in Rails 4.

## Installation

Add this line to your application's Gemfile:

    gem 'transmitter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install transmitter

## Usage

To use Transmitter, simply create a routable action in your controller that will represent the event source for transmitting the Server-Sent Events, and then use the `transmit` method to send accross an event and data payload to the client.

Transmit takes a hash that __MUST__ contain an `event` key and a `data` key. Optionally you may also supply a `retry` key which will signify how long the client should wait to attempt to reconnect.

```ruby
FoosController < ActionController::Base
  include ActionController::Live

  ...

  def transmit_action
    stream do
      transmit event: 'event', retry: 1000, data: { my: 'really', cool: 'message' }
    end
  end

  ...

end
```

This will create a properly formatted Server-Sent Event using the functionality of ActionController::Live.

To consume this event on the client side, simply use the Javascript EventSource API:

```coffeescript
$ ->
  source = new EventSource('your/eventsource/url')
  source.addEventListener 'your_event', (message) ->
    # now the data that you send along will be available in
    # message.data, and will come in the form of a JSON document
```

## Requirements

  * Transmitter relies on the ActionController::Live functionality of Rails 4

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT
