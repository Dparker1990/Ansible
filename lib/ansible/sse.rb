module Ansible
  class SSE
    attr_reader :stream

    def initialize(stream)
      @stream = stream
    end

    def write(event, message)
      stream.write "event: #{event}"
      stream.write "data: #{message}"
    end

    def close
      stream.close
    end
  end
end
