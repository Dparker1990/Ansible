require 'json'

module Ansible
  class SSE
    attr_reader :stream

    def initialize(stream)
      @stream = stream
    end

    def write(event, retry_connection, message)
      stream.write "event: #{event}\n"
      stream.write "retry: #{retry_connection}\n"
      stream.write "data: #{JSON.dump message}\n\n"
    end

    def close
      stream.close
    end
  end
end
