require 'action_controller'
require 'ansible/transmit'

class TestController < ActionController::Base
  extend Ansible::Transmit

  transmit :space
end

describe Ansible::Transmit do
  describe '.extended' do
    let(:controller) { TestController.new }

    it 'adds a before filter to add correct content-type for beacon actions' do
      controller.class._process_action_callbacks.should_not eq []
    end
  end

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

    # move this into a rails integration spec
    describe 'the method .transmit creates' do
      it 'sets the content-type to text/event-stream' do
        pending
      end
    end
  end
end
