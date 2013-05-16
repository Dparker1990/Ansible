require 'action_controller'
require 'ansible/transmit'

class TestController < ActionController::Base
  extend Ansible::Transmit

  transmit :space
end

describe Ansible::Transmit do
  describe '.transmit' do
    let(:controller) { TestController.new }

    it 'defines a method in the format name_ansible_beacon' do
      controller.should respond_to :space_ansible_beacon
    end

    it 'allows the action to be routable' do
      controller.hidden_actions.should_not include :space_ansible_beacon
    end

    it 'adds the new beacon name to _beacons' do
      controller.class._beacons.should include :space_ansible_beacon
    end
  end
end
