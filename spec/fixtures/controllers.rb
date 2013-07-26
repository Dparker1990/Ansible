require 'fixtures/fake_rails_app'

class TestsController < ActionController::Base
  include Rails.application.routes.url_helpers
  include ActionController::Live

  def new
    render text: "new"
  end

  def create
    head :ok
  end

  def space_beacon
    stream do
      transmit event: 'space', retry: 1000, data: { expanding: true }
    end
  end
end
