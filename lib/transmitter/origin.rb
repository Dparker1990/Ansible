module Transmitter
  module Origin
    def transmit(opts)
      set_headers
      sse.build_message(opts).stream unless stream_closed?
    end

    def close_connection
      sse.close
    end

    def stream_closed?
      response.stream.closed?
    end

    def set_headers
      return if headers['Content-Type'] == 'text/event-stream'
      headers['Content-Type'] = 'text/event-stream'
    end

    def sse
      @sse ||= SSE.new response.stream
    end
  end
end
