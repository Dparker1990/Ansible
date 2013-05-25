module Ansible
  module Transmit
    def self.extended(base)
      base.class_eval do
        include ActionController::Live
      end
    end

    def transmit(name)
      @name = name
      _beacons << beacon_name.to_sym

      define_method beacon_name, beacon_action
      define_method :transmit_message, -> { transmit_que << 'test message' }
      define_method :transmit_que, -> { @_transmit_que ||= [] }
      beacon_name
    end

    def _beacons
      @_beacons ||= []
    end

    private

    def beacon_name
      "#{@name}_ansible_beacon"
    end

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
