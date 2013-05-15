require 'fixtures/fake_rails_app'

class TestsController < ActionController::Base
  include Rails.application.routes.url_helpers
  extend Ansible::Transmit

  transmit :space
end
