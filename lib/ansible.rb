require 'ansible/transmit'

ActiveSupport.on_load(:controller) do
  extend Ansible::Transmit
end
