require 'fixtures/controllers'
require 'rspec/rails'
require 'spec_helper'

describe TestsController, type: :controller do
  describe 'GET space_ansible_beacon' do
    before do
      Space.stub(:on_new_message).and_yield('space', '{"expanding":true}')
      get beacon_route
    end

    let(:beacon_route) { :space_ansible_beacon }
    let(:message) { %{event: space\ndata: {"expanding":true}\n\n} }

    it 'sets the content-type to text/event-stream' do
      response.headers['Content-Type'].should eq 'text/event-stream'
    end

    it 'sends the next messages in the que concerning the current modal' do
      sleep 0.1 until response.stream.closed?
      response.body.should eq message
    end

    it 'does not override predefined routes' do
      post :create
      response.should be_ok
    end
  end
end
