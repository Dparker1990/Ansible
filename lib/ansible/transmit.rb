module Ansible
  module Transmit
    def self.extended(base)
      base.class_eval do
        include ActionController::Live

        def self._beacons
          @_beacons ||= []
        end

        before_filter :alert_beacons, only: @_beacons # Figure out a sane filter
      end
    end

    def transmit(name)
      _beacons << :"#{name}_ansible_beacon"

      define_method "#{name}_ansible_beacon" do
        raise NotImplementedError
      end
    end
  end
end
