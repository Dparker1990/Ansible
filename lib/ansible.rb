require 'ansible/transmit'

ActiveSupport.on_load(:action_controller) do
  extend Ansible::Transmit
end
