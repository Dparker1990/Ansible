require 'json'

module Ansible
  class SSE
    attr_reader :stream

    def initialize(stream)
      @stream = stream
    end

    def write(event, message)
      stream.write "event: #{event}\n"
      stream.write "data: #{JSON.generate message}\n\n"
    end

    def close
      stream.close
    end
  end
end
