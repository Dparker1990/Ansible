module Ansible
  module Transmit
    def self.extended(base)
      base.class_eval do
        include ActionController::Live

        def self._beacons
          @_beacons ||= []
        end
      end
    end

    def transmit(name)
      _beacons << :"#{name}_ansible_beacon"

      define_method "#{name}_ansible_beacon" do
        response.headers['Content-Type'] = 'text/event-stream'
      end
    end
  end
end
