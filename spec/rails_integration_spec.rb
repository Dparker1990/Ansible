require 'fixtures/controllers'
require 'rspec/rails'

describe TestsController, type: :controller do
  describe 'GET space_ansible_beacon' do
    before do
      described_class.any_instance.stub transmit_que: {
        space_ansible_beacon: [ { new: ['bar'] } ],
        space: 'foo'
      }
      get beacon_route
    end

    let(:beacon_route) { :space_ansible_beacon }
    let(:message) do
      "event: new\ndata: [\"bar\"]\n\n"
    end

    it 'sets the content-type to text/event-stream' do
      response.headers['Content-Type'].should eq 'text/event-stream'
    end

    it 'sends the next messages in the que concerning the current modal' do
      sleep 0.1 until response.stream.closed?
      response.body.should eq message
    end
  end
end
