require 'ansible/sse'
require 'ansible/constant_resolver'
require 'ansible/transmit_model'
require 'ansible/transmit_controller'

ActiveSupport.on_load(:active_record) do
  extend Ansible::TransmitModel
end

ActiveSupport.on_load(:action_controller) do
  extend Ansible::TransmitController
end
