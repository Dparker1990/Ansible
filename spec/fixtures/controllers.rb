require 'fixtures/fake_rails_app'

class TestsController < ActionController::Base
  include Rails.application.routes.url_helpers

  def new
    render text: "new"
  end

  def create
    head :ok
  end

  def space_beacon
    transmit 'space', expanding: true
  end

  def space_params
    params.require(:space).permit(:expanding)
  end
end
