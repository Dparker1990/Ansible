require 'ansible/sse'
require 'ansible/constant_resolver'
require 'ansible/transmit_controller'

ActiveSupport.on_load(:action_controller) do
  include Ansible::TransmitController
end
