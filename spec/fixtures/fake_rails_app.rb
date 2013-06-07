require 'active_support/all'
require 'action_controller'
require 'action_dispatch'
require 'active_model'
require 'active_record'
require 'rails'
require 'ostruct'
require 'ansible-rails'

module Rails
  class App
    def env_config; {} end

    def routes
      return @routes if defined? @routes

      @routes = ActionDispatch::Routing::RouteSet.new.tap do |routes|
        routes.draw do
          post '/test' => 'tests#create'
          get '/test/space_beacon' => 'tests#space_beacon'
        end
      end
    end
  end

  def self.application
    @app ||= App.new
  end
end
