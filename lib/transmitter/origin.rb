module Transmitter
  module Origin
    def stream
      begin
        set_headers
        yield
      ensure
        close_connection
      end
    end

    def transmit(opts)
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
