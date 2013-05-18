require 'action_controller'
require 'ansible/transmit'

class TestController < ActionController::Base
  extend Ansible::Transmit

  transmit :space
end

describe Ansible::Transmit do
  describe '.transmit' do
    let(:controller) { TestController.new }
    let(:action_name) { :space_ansible_beacon }

    it 'defines a method in the format name_ansible_beacon' do
      controller.should respond_to action_name
    end

    it 'allows the action to be routable' do
      controller.hidden_actions.should_not include action_name
    end

    it 'adds the new beacon name to _beacons' do
      controller.class._beacons.should include action_name
    end
  end
end
