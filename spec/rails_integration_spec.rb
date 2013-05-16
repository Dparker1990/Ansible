require 'fixtures/controllers'
require 'rspec/rails'

describe TestsController, type: :controller do
  describe 'GET space_ansible_beacon' do
    it 'sets the content-type to text/event-stream' do
      get :space_ansible_beacon

      response.headers['Content-Type'].should eq 'text/event-stream'
    end
  end
end
