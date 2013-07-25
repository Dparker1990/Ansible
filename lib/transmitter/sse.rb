require 'json'

module Transmitter
  class SSE
    attr_reader :stream

    def initialize(stream)
      @stream = stream
    end

    def write(event, retry_connection, data)
      message = "event: #{event}\n"
      message << "retry: #{retry_connection}\n"
      message << "data: #{JSON.dump data}\n\n"
      stream.write message
    end

    def close
      stream.close
    end
  end
end
