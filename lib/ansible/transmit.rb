module Ansible
  module Transmit
    def self.extended(base)
      base.class_eval { include ActionController::Live }
    end

    def transmit(name)
      beacon_name = :"#{name}_ansible_beacon"
      build_route beacon_name
      model = ConstantResolver.new(name).lookup_constant

      model.extend TransmitModalHelper

      define_method beacon_name, beacon_action
      name
    end

    def build_route(beacon_name)
      controller_name = self.to_s.underscore.gsub('_controller', '')
      safely_add_route do
        Rails.application.routes.draw do
          get "/#{controller_name}/#{beacon_name}" => "#{controller_name}##{beacon_name}"
        end
      end
    end

    def safely_add_route
      remove_clear
      yield
      reimplement_clear
    end

    def remove_clear
      ActionDispatch::Routing::RouteSet.class_eval do
        def clear_fake
          -> {}
        end
        alias_method :real_clear!, :clear!
        alias_method :clear!, :clear_fake
      end
    end

    def reimplement_clear
      ActionDispatch::Routing::RouteSet.class_eval do
        alias_method :clear!, :real_clear!
      end
    end

    private

    def beacon_action
      Proc.new do
        begin
          beacon = __method__
          model = ConstantResolver.new(beacon.to_s.split("_").first).lookup_constant

          headers['Content-Type'] = 'text/event-stream'
          sse = SSE.new(response.stream)

          model.on_new_message do |event, message|
            sse.write event, message
          end
        ensure
          sse.close
        end
      end
    end

    module TransmitModalHelper
      def self.extended(base)
        base.class_eval do
          after_commit :notify

          def notify
            connection.execute "NOTIFY #{self.class.table_name}, #{self.class.connection.quote attributes}"
          end
        end
      end

      def on_new_message
        listen

        connection.raw_connection.wait_for_notify do |event, pid, message|
          yield event, message
        end
      end

      def listen
        connection.execute "LISTEN #{table_name}"
      end
    end
  end
end
