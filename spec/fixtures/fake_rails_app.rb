require 'active_support/all'
require 'action_controller'
require 'action_dispatch'
require 'active_model'
require 'active_record'
require 'rails'
require 'ansible'

module Rails
  class App
    def env_config; {} end
    def routes
      return @routes if defined? @routes

      @routes = ActionDispatch::Routing::RouteSet.new.tap do |routes|
        routes.draw do
          get '/test/space_ansible_beacon' => "tests#space_ansible_beacon"
          get '/test/new' => "tests#new"
          post '/test' => "tests#new"
        end
      end
    end
  end

  def self.application
    @app ||= App.new
  end
end
