module Ansible
  module Transmit
    def self.extended(base)
      base.class_eval { include ActionController::Live }
    end

    def transmit(name)
      beacon_name = :"#{name}_ansible_beacon"
      active_beacons << beacon_name

      define_method beacon_name, beacon_action
      name
    end

    def active_beacons
      @_beacons ||= []
    end

    private

    def beacon_action
      Proc.new do
        begin
          beacon = __method__
          response.headers['Content-Type'] = 'text/event-stream'
          sse = SSE.new(response.stream)
          loop do
            break if transmit_que[beacon].empty?
            event, message = transmit_que[beacon].pop.flatten
            sse.write(event, message)
          end
        ensure
          sse.close
        end
      end
    end
  end
end
