require 'action_controller'
require 'ansible/transmit'

class TestsController < ActionController::Base
  extend Ansible::Transmit

  transmit :space

  def create
    head :ok
  end
end

describe Ansible::Transmit do
  describe '.transmit' do
    let(:controller) { TestsController.new }
    let(:action_name) { :space_ansible_beacon }

    it 'defines a method in the format name_ansible_beacon' do
      controller.should respond_to action_name
    end

    it 'allows the action to be routable' do
      controller.hidden_actions.should_not include action_name
    end
  end
end
