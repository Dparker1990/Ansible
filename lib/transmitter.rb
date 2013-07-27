require 'transmitter/counter'
require 'transmitter/sse'
require 'transmitter/constant_resolver'
require 'transmitter/origin'

ActiveSupport.on_load(:action_controller) do
  include Transmitter::Origin
end
