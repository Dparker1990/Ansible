require 'fixtures/fake_rails_app'

class TestsController < ActionController::Base
  include Rails.application.routes.url_helpers

  transmit :space
end
