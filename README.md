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

The first arguement to `transmit` is the event name, the second arguement is amount of time between the client attempting to re-establish connection (in milliseconds), and the last argument is a hash containing the data that should be sent to the client.

```ruby
FoosController < ActionController::Base
  include ActionController::Live

  ...

  def transmit_action
    transmit 'event', 1000, my: 'really', cool: 'message'
    close_connection # you must manually close the connection
  end

  ...

end
```

This will create a properly formatted Server-Sent Event using the functionality of ActionController::Live.

To consume this event on the client side, simply use the Javascript EventSource API:

```javascript
$(document).ready(function(){
  var source = new EventSource('your/eventsource/url');
  source.addEventListener('your_event', function(message){
    // now the data that you send along will be available in
    // message.data, and will come in the form of a JSON document
  });
});
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
