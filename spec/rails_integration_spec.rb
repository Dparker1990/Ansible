require 'fixtures/controllers'
require 'rspec/rails'

describe TestsController, type: :controller do
  describe 'GET space_ansible_beacon' do
    let(:beacon_route) { :space_ansible_beacon }
    it 'sets the content-type to text/event-stream' do
      get beacon_route

      response.headers['Content-Type'].should eq 'text/event-stream'
    end

    it 'sends the updated attributes of the model upon update' do
      post :new

      Timeout::timeout(1) do
        get beacon_route
      end
      require 'pry'; binding.pry
      response.body.should eq '{"thing": "stuff"}'
    end
  end
end
