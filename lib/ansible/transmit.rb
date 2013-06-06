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
      Rails.application.routes.draw do
        Rails.application.routes.routes.named_routes.each do |path, route|
          get path, route.defaults
        end
        get "/#{controller_name}/#{beacon_name}" => "#{controller_name}##{beacon_name}"
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

        connection.wait_for_notify do |event, pid, message|
          yield event, message
        end
      end

      def listen
        connection.execute "LISTEN #{table_name}"
      end
    end
  end
end
